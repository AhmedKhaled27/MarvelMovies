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
    
    //MARK: Properites
    var viewModel: MovieCellViewModel? {
        didSet { setupViewModel() }
    }
    
    //MARK: Properites
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupViewModel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    //MARK: Helper Functions
    private func setupViewModel() {
        guard let viewModel = viewModel else { return }
        setupNameLabelWithName(viewModel.movieName)
//        setupDateLabelWithDate(viewModel.data)
        setupRatingLabelWithRate(viewModel.rating)
        setupMovieImageWithURL(viewModel.movieThumbnailURL)
        setupCmponentsForCellState(viewModel.cellState)
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
    
    private func setupCmponentsForCellState(_ state: MovieCellState) {
        switch state {
        case .collapsed:
            print("movie cell collapsed")
            loadingContainerView.isHidden = true
        case let .expanded(isLoading):
            print("movie cell expanded and isLoading -> \(isLoading)")
            loadingContainerView.isHidden = !isLoading
        }
        layoutIfNeeded()
    }
}
