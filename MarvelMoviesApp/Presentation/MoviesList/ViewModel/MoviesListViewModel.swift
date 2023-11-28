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
    
    //MARK: Initialzer
    init(getMoviesListUseCase: GetMoviesList) {
        self.getMoviesListUseCase = getMoviesListUseCase
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
        currentPage += 1
        getMoviesList(page: currentPage,
                      loadingType: .nextPage)
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
}
