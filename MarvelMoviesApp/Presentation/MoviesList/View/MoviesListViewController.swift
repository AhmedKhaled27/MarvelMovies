//
//  MoviesListViewController.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 27/11/2023.
//

import UIKit
import SkeletonView

class MoviesListViewController: UIViewController {
    //MARK: OutLets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properites
    private var viewModel: MoviesListViewModelProtocol
    
    var nextPageLoadingSpinner: UIActivityIndicatorView?

    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
    
    //MARK: Initialzer
    init(viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: MoviesListViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Helper Functions
extension MoviesListViewController {
    private func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Movies List"
        setupNavigationItemSearchBar()
        setupTableView()
        setupViewModel()
    }
    
    private func setupNavigationItemSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = AppColors.color_D83933.color
        //        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "search movies"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isSkeletonable = true
        tableView.register(cellWithClass: MovieSkeletonCell.self)
        tableView.register(cellWithClass: MovieItemCell.self)
    }
}

//MARK: ViewModel
extension MoviesListViewController {
    private func setupViewModel() {
        bindLoading()
        bindMoviesResponseState()
    }
    
    private func bindLoading() {
        viewModel.loading.bind({ [weak self] loading in
            guard let self = self else { return }
            switch loading {
            case .none:
                self.tableView.hideSkeleton()
//                self.tableView.tableFooterView = nil
                
            case .fullScreen:
                self.tableView.showAnimatedGradientSkeleton()
                
            case .nextPage:
                self.nextPageLoadingSpinner?.removeFromSuperview()
                self.nextPageLoadingSpinner = self.makeActivityIndicator(size: .init(width: self.tableView.frame.width, height: 44))
                self.tableView.tableFooterView = self.nextPageLoadingSpinner
            }
            
        })
    }
    
    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                style = .white
            } else {
                style = .gray
            }
        } else {
            style = .gray
        }

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
    
    private func bindMoviesResponseState() {
        viewModel.moviesResponseState.bind({ [weak self] responseState in
            guard let self = self,
                  let responseState = responseState else {return}
            switch responseState {
            case .success:
                self.tableView.reloadData()
            case let .failure(errorMessage: message):
                break
            }
        })
    }
    
    private func bindMoviesList() {
        
    }
    
}

//MARK: UITableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: UITableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MovieItemCell.self, for: indexPath)
        if let cellViewModel = viewModel.getMovieCellViewModel(forCellAtIndex: indexPath.item) {
            cell.viewModel = cellViewModel
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if (offsetY > tableView.contentSize.height-50 - scrollView.frame.size.height)  {
            viewModel.loadMoreMovies()
        }
    }
}

extension MoviesListViewController: SkeletonTableViewDataSource {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MovieSkeletonCell.className
    }
    
}
