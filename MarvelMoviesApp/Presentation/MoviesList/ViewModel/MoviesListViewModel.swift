//
//  MoviesListViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation
import Moya

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
    private lazy var getMoviesListUseCase: GetMoviesList = GetMoviesListUseCase()
    private lazy var searchMoviesUseCase: SearchMovies = SearchMoviesUseCase()
    private lazy var getMovieDetailsByIdUseCase: GetMovieDetailsByID = GetMovieDetailsByIDUseCase()
    
    //MARK: Properties
    private var moviesList: [Movie] = []
    private var totalMovies = 0
    private var currentPage = 1
    private var hasMoreMovies: Bool {
        moviesList.count < totalMovies
    }
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    
    var loading: Observable<MoviesListViewModelLoading> = Observable(.none)
    var moviesResponseState: Observable<GetMoviesResponseState> = Observable(nil)
    
    //TableViewDataSource
    private var moviesCellsViewModels: [MovieCellViewModel] = []
    var numberOfItems: Int {
        return moviesCellsViewModels.count
    }
    var selectedMovieIndex: Observable<Int> = Observable(nil)
    
    //SearchBar
    var searchKey: Observable<String> = Observable(nil)
    private var isSearchingEnabled = false
    private var didSearchUsed = false
    
}

//MARK: Conform to MoviesListViewModel
extension MoviesListViewModel: MoviesListViewModelProtocol {
    func viewDidLoad() {
        getMoviesList(page: currentPage,
                      loadingType: .fullScreen)
    }
    //TableView
    func getMovieCellViewModel(forCellAtIndex index: Int) -> MovieCellViewModel? {
        return moviesCellsViewModels[index]
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
        let currentState = moviesCellsViewModels[index].cellState
        switch currentState {
        case .collapsed:
            moviesCellsViewModels[index]
                .updateCellState(newState: .expanded(isLoading: true))
            
            guard let movieId = moviesList[index].id else { return }
            getMovieDetailsById(movieId: movieId,
                                completionHander: { [weak self] movieDetails in
                guard let self = self,
                      let movieDetails = movieDetails,
                      let movieDetailsId = movieDetails.id,
                      index < self.moviesList.count,
                      movieDetailsId == self.moviesList[index].id else { return }
                
                
                self.moviesCellsViewModels[index].detailsViewModel = MovieDetailsViewModel(movieDetails: movieDetails)
                self.moviesCellsViewModels[index].updateCellState(newState: .expanded(isLoading: false))
                self.selectedMovieIndex.value = index
            })
            
        case .expanded:
            moviesCellsViewModels[index]
                .updateCellState(newState: .collapsed)
        }
        selectedMovieIndex.value = index
    }
    //SearchBar
    func didSearch(searchKey: String) {
        guard searchKey != self.searchKey.value else {return}
        resetPagesData()
        didSearchUsed = true
        self.searchKey.value = searchKey
        if !searchKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            searchMovies(page: currentPage,
                         searchKey: searchKey,
                         loadingType: .fullScreen)
        }else {
            getMoviesList(page: currentPage,
                          loadingType: .fullScreen)
        }
    }
    
    func setSearchingIsEnabled(_ isEnabled: Bool) {
        isSearchingEnabled = isEnabled
        searchKey.value = .none
        if !isEnabled && didSearchUsed {
            didSearchUsed = false
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
        moviesLoadTask = getMoviesListUseCase.execute(page: currentPage) { [weak self] result in
            guard let self = self else {return}
            self.loading.value = .none
            switch result {
            case let .success(response):
                defer { self.moviesResponseState.value = .success }
                if let movies = response.movies,
                   !movies.isEmpty {
                    self.moviesList.append(contentsOf: movies)
                    self.moviesCellsViewModels.append(contentsOf: movies.map({ MovieCellViewModel(movie: $0)} ))
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
        moviesLoadTask = searchMoviesUseCase.execute(page: page,
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
                    self.moviesCellsViewModels.append(contentsOf: movies.map({ MovieCellViewModel(movie: $0)} ))
                }
                self.totalMovies = response.total ?? 0
                
            case .failure:
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
        moviesCellsViewModels = []
    }
    
    private func getMovieDetailsById(movieId: Int,
                                     completionHander: @escaping (MovieDetails?) -> Void) {
        getMovieDetailsByIdUseCase.execute(movieId: movieId,
                                           completionHandler: { result in
            switch result {
            case let .success(response):
                completionHander(response)
            case .failure:
                completionHander(nil)
            }
        })
    }
}
