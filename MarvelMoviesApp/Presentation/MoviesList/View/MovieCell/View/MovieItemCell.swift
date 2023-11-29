//
//  MovieItemCell.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import UIKit
import Kingfisher

class MovieItemCell: UITableViewCell {
    //MARK: IBOutLets
    @IBOutlet private var containerView: UIStackView! {
        didSet {
            containerView.layer.cornerRadius = 25
            containerView.layer.borderColor = AppColors.color_D83933.color.cgColor
            containerView.layer.borderWidth = 1
        }
    }
    @IBOutlet private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 25
            thumbnailImageView.layer.borderColor = AppColors.color_D83933.color.cgColor
            thumbnailImageView.layer.borderWidth = 1
        }
    }
    @IBOutlet private var nameLabel: UILabel!
    //    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
        //Loading
    @IBOutlet weak var loadingContainerView: UIView!
    @IBOutlet weak var movieDetailsContainerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    //Description
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
        //Creators
    @IBOutlet weak var creatorsCollectionView: UICollectionView!
    @IBOutlet weak var noCreatorsLabel: UILabel!
    
    //MARK: Properties
    var viewModel: MovieCellViewModel? {
        didSet { setupViewModel() }
    }
    
    //MARK: Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupViewModel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    //MARK: Helper Functions
    private func setupUI() {
        selectionStyle = .none
        setupCreatorsCollectionView()
        setupTitels()
    }
    
    private func setupTitels() {
        noCreatorsLabel.text = "Movie doesn't have creators"
    }
    
    private func setupCreatorsCollectionView() {
        creatorsCollectionView.delegate = self
        creatorsCollectionView.dataSource = self
        creatorsCollectionView.register(cellWithClass: CreatorCell.self)
        creatorsCollectionView.collectionViewLayout = createCreatorsCollectionViewLayout()
    }
    
    func createCreatorsCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                              heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 5
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

}

//MARK: Setup viewModel
extension MovieItemCell {
    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        setupNameLabelWithName(viewModel.movieName)
        //        setupDateLabelWithDate(viewModel.data)
        setupRatingLabelWithRate(viewModel.rating)
        setupMovieImageWithURL(viewModel.movieThumbnailURL)
        setupComponentsForCellState(viewModel.cellState)
        setupMovieDetailsViewModel(detailsViewModel: viewModel.detailsViewModel)
    }
    
    private func setupNameLabelWithName(_ name: String?) {
        if let movieName = name,
           !movieName.isEmpty {
            nameLabel.isHidden = false
            nameLabel.text = movieName
        }else {
            nameLabel.isHidden = true
        }
    }
    
    //    private func setupDateLabelWithDate(_ date: Int?) {
    //        if let date = date {
    //            dateLabel.isHidden = false
    //            dateLabel.text = "relase date: \(date)"
    //        }else {
    //            dateLabel.isHidden = true
    //        }
    //    }
    
    private func setupRatingLabelWithRate(_ rate: String?) {
        if let rate = rate {
            ratingLabel.isHidden = false
            ratingLabel.text = rate
        }else {
            ratingLabel.isHidden = true
        }
    }
    
    private func setupMovieImageWithURL(_ imageURL: URL?){
        thumbnailImageView.kf.indicatorType = .activity
        thumbnailImageView.kf.setImage(with: imageURL)
    }
    
    private func setupComponentsForCellState(_ state: MovieCellState) {
        switch state {
        case .collapsed:
            loadingContainerView.isHidden = true
            loadingIndicator.startAnimating()
            movieDetailsContainerView.isHidden = true
            
        case let .expanded(isLoading):
            loadingContainerView.isHidden = !isLoading
            movieDetailsContainerView.isHidden = isLoading
            if isLoading { loadingIndicator.startAnimating() }
            else { loadingIndicator.stopAnimating() }
            
        }
        layoutIfNeeded()
    }
}

//MARK: Setup DetailsViewModel
extension MovieItemCell {
    private func setupMovieDetailsViewModel(detailsViewModel: MovieDetailsViewModel?) {
        
        guard let detailsViewModel = detailsViewModel else {
            movieDetailsContainerView.isHidden = true
            return
        }
        setupMovieDescription(detailsViewModel.description)
        
        if detailsViewModel.numberOfCreators == 0 {
            creatorsCollectionView.isHidden = true
            noCreatorsLabel.isHidden = false
        }else {
            creatorsCollectionView.isHidden = false
            noCreatorsLabel.isHidden = true
            creatorsCollectionView.reloadData()
        }
    }
    
    private func setupMovieDescription(_ description: String?) {
        if let description = description,
           !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            descriptionStackView.isHidden = false
            descriptionLabel.text = description
        }else {
            descriptionLabel.text = "Movie doesn't have a description."
        }
    }
}

//MARK: UICollectionViewDelegate
extension MovieItemCell: UICollectionViewDelegate {
    
}

//MARK: UICollectionViewDataSource
extension MovieItemCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == creatorsCollectionView {
            guard let detailsViewModel = viewModel?.detailsViewModel else { return 0 }
            return detailsViewModel.numberOfCreators
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == creatorsCollectionView {
            guard let detailsViewModel = viewModel?.detailsViewModel else {
                return UICollectionViewCell()
            }
            
            let cell = collectionView.dequeueReusableCell(withClass: CreatorCell.self, for: indexPath)
            cell.viewModel = detailsViewModel.getCreatorItemCellViewModel(atIndex: indexPath.item)
            return cell
            
        }else {
            return UICollectionViewCell()
        }
    }
}
