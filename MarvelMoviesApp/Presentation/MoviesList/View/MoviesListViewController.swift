//
//  MoviesListViewController.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 27/11/2023.
//

import UIKit
import SkeletonView

class MoviesListViewController: BaseViewController {
    //MARK: OutLets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properites
    private var viewModel: MoviesListViewModelProtocol
    
    private var nextPageLoadingSpinner: UIActivityIndicatorView?
    private lazy var searchController = UISearchController(searchResultsController: nil)

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
        title = "Movies"
        setupNavigationItemSearchBar()
        setupTableView()
        setupViewModel()
    }
    
    private func setupNavigationItemSearchBar() {
        searchController.searchBar.tintColor = AppColors.color_D83933.color
        searchController.delegate = self
        searchController.searchBar.delegate = self
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
    
    private func scrollToTableViewTop() {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                   at: .top,
                                   animated: false)
    }
}

//MARK: ViewModel
extension MoviesListViewController {
    private func setupViewModel() {
        bindLoading()
        bindMoviesResponseState()
        bindSearchKey()
        bindMoviesList()
    }
    
    private func bindLoading() {
        viewModel.loading.bind({ [weak self] loading in
            guard let self = self else { return }
            switch loading {
            case .none:
                self.tableView.hideSkeleton()
                self.tableView.tableFooterView = nil
                
            case .fullScreen:
                self.tableView.showAnimatedGradientSkeleton()
                
            case .nextPage:
                self.nextPageLoadingSpinner?.removeFromSuperview()
                self.nextPageLoadingSpinner = self.makeActivityIndicator(size: .init(width: self.tableView.frame.width, height: 44))
                self.tableView.tableFooterView = self.nextPageLoadingSpinner
            }
            
        })
    }
    
    private func bindMoviesResponseState() {
        viewModel.moviesResponseState.bind({ [weak self] responseState in
            guard let self = self,
                  let responseState = responseState else {return}
            switch responseState {
            case .success:
                self.tableView.reloadData()
            case let .failure(errorMessage: message):
                self.showErrorAlert(string: message)
            }
        })
    }
    
    private func bindMoviesList() {
        viewModel.moviesCellsViewModels.bind({ [weak self] _ in
            guard let self = self else {return}
            self.tableView.reloadData()
        })
    }
    
    private func bindSearchKey() {
        viewModel.searchKey.bind({ [weak self] searchKey in
            guard let self = self,
                  let searchKey = searchKey else {return}
            self.searchController.searchBar.text = searchKey
        })
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

//MARK: SkeletonTableViewDataSource
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

//MARK: conform to UISearchBarDelegate
extension MoviesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        viewModel.didSearch(searchKey: searchText)
        scrollToTableViewTop()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.setSearchingIsEnabled(false)
        scrollToTableViewTop()
    }
}

extension MoviesListViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.setSearchingIsEnabled(true)
        scrollToTableViewTop()
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.setSearchingIsEnabled(false)
        scrollToTableViewTop()
    }
}
