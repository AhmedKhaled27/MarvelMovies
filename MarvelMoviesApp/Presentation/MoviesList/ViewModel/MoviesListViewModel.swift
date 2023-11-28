//
//  MoviesListViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

enum GetMoviesResponseState {
    case success
    case failure(errorMessage: String)
}

class MoviesListViewModel {
    //MARK: UseCases
    private let getMoviesListUseCase: GetMoviesList
    private let searchMoviesUseCase: SearchMovies
    
    //MARK: Properites
    private var moviesList: [Movie] = [] {
        didSet {
            moviesCellsViewModels.value = moviesList.map({ MovieCellViewModel(movie: $0) })
        }
    }
    private var totalMovies = 0
    private var currentPage = 1
    private var hasMoreMovies: Bool {
        moviesList.count < totalMovies
    }
    
    var loading: Observable<MoviesListViewModelLoading> = Observable(.none)
    var moviesResponseState: Observable<GetMoviesResponseState> = Observable(nil)
    
        //TableViewDataSource
    var moviesCellsViewModels: Observable<[MovieCellViewModel]> = Observable(nil)
    var numberOfItems: Int {
        guard let movies = moviesCellsViewModels.value else { return 0 }
        return movies.count
    }
        //SearchBar
    var searchKey: Observable<String> = Observable(nil)
    private var isSearchingEnabled = false
    
    //MARK: Initialzer
    init(getMoviesListUseCase: GetMoviesList,
         searchMoviesUseCase: SearchMovies) {
        self.getMoviesListUseCase = getMoviesListUseCase
        self.searchMoviesUseCase = searchMoviesUseCase
    }
}

//MARK: Conform to MoviesListViewModel
extension MoviesListViewModel: MoviesListViewModelProtocol {
    func viewDidLoad() {
        getMoviesList(page: currentPage,
                      loadingType: .fullScreen)
    }
        //TableView
    func getMovieCellViewModel(forCellAtIndex index: Int) -> MovieCellViewModel? {
        return moviesCellsViewModels.value?[index]
    }
    
    func loadMoreMovies() {
        guard loading.value == .none,
              hasMoreMovies else { return }
        if isSearchingEnabled,
           let searchKey = searchKey.value,
           !searchKey.isEmpty {
            currentPage += 1
            searchMovies(page: currentPage,
                         searchKey: searchKey,
                         loadingType: .nextPage)
        }else {
            currentPage += 1
            getMoviesList(page: currentPage,
                          loadingType: .nextPage)
        }
    }
    
    func didSelectMovieCell(atIndex index: Int) {
        guard let moviesViewModels = moviesCellsViewModels.value else {return}
        let currentState = moviesViewModels[index].cellState
        var newState: MovieCellState = .collapsed
        switch currentState {
        case .collapsed: newState = .expanded(isLoading: true)
        case .expanded: newState = .collapsed
        }
        moviesCellsViewModels.value?[index].updateCellState(newState: newState)
    }
        //SearchBar
    func didSearch(searchKey: String) {
        resetPagesData()
        self.searchKey.value = searchKey
        searchMovies(page: currentPage,
                     searchKey: searchKey,
                     loadingType: .fullScreen)
    }
    
    func setSearchingIsEnabled(_ isEnabled: Bool) {
        isSearchingEnabled = isEnabled
        searchKey.value = .none
        if !isEnabled {
            resetPagesData()
            getMoviesList(page: currentPage,
                          loadingType: .fullScreen)
        }
        
    }
}

//MARK: Private Functions
extension MoviesListViewModel {
    private func getMoviesList(page: Int,
                               loadingType: MoviesListViewModelLoading) {
        loading.value = loadingType
        getMoviesListUseCase.execute(page: currentPage) { [weak self] result in
            guard let self = self else {return}
            self.loading.value = .none
            switch result {
            case let .success(response):
                defer { self.moviesResponseState.value = .success }
                if let movies = response.movies,
                   !movies.isEmpty {
                    self.moviesList.append(contentsOf: movies)
                }
                self.totalMovies = response.total ?? 0
                
            case .failure(_):
                let message = "Failed to get movies data"
                self.moviesResponseState.value = .failure(errorMessage: message)
                if self.currentPage != 1 { self.currentPage -= 1 }
            }
        }
    }
    
    private func searchMovies(page: Int,
                              searchKey: String,
                              loadingType: MoviesListViewModelLoading) {
        loading.value = loadingType
        searchMoviesUseCase.execute(page: page,
                                    searchKey: searchKey,
                                    completionHandler: { [weak self] result in
            guard let self = self else {return}
            self.loading.value = .none
            switch result {
            case let .success(response):
                defer { self.moviesResponseState.value = .success }
                if let movies = response.movies,
                   !movies.isEmpty {
                    self.moviesList.append(contentsOf: movies)
                }
                self.totalMovies = response.total ?? 0
                
            case .failure(_):
                let message = "Failed to get movies matching query"
                self.moviesResponseState.value = .failure(errorMessage: message)
                if self.currentPage != 1 { self.currentPage -= 1 }
            }
        })
    }
    
    private func resetPagesData() {
        currentPage = 1
        totalMovies = 0
        moviesList = []
    }
}
