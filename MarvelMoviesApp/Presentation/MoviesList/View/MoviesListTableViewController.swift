//
//  MoviesListTableViewController.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 27/11/2023.
//

import UIKit
import SkeletonView

class MoviesListTableViewController: UITableViewController {
    //MARK: Properites
    private var viewModel: MoviesListViewModelProtocol
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }
  
    //MARK: Initialzer
    init(viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: MoviesListTableViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Helper Functions
extension MoviesListTableViewController {
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
        searchController.searchBar.tintColor = .red
        //        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "search movies"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.isSkeletonable = true
        tableView.register(cellWithClass: MovieSkeletonCell.self)
    }
}

//MARK: ViewModel
extension MoviesListTableViewController {
    private func setupViewModel() {
        bindLoading()
    }
    
    private func bindLoading() {
        viewModel.loading.bind({ [weak self] loading in
            guard let self = self else { return }
            switch loading {
            case .none:
//                self.tableView.hideSkeleton()
                break
                
            case .fullScreen:
                self.tableView.showAnimatedGradientSkeleton()
                
            case .nextPage:
                break
            }
            
        })
    }
}

//MARK: UITableViewDelegate - DataSource
extension MoviesListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MoviesListTableViewController: SkeletonTableViewDataSource {
    
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
