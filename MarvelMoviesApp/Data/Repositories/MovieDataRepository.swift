//
//  MovieDataRepository.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

class MovieDataRepository {
    //MARK: Properties
    private lazy var moviesRemoteDataService: MoviesRemoteDataServiceProtocol = MoviesRemoteDataService()
    private lazy var moviesLocalDataService: MoviesLocalDataServiceProtocol = MoviesLocalDataService()
}

//MARK: Conform to MovieRepository
extension MovieDataRepository: MovieRepository {
    func getMoviesList(page: Int, completionHandler: @escaping ((Result<Movies, Error>) -> Void)) {
        moviesRemoteDataService.getMoviesList(page: page,
                                              completionHandler: { result in
            switch result {
            case let .success(response):
                guard let data = response.data else {
                    completionHandler(.failure("Cann't get movies data"))
                    return
                }
                completionHandler(.success(data.toDomain()))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func searchMovies(page: Int, searchKey: String, completionHandler: @escaping ((Result<Movies, Error>) -> Void)) {
        moviesRemoteDataService.searchMovies(page: page,
                                             searchKey: searchKey,
                                             completionHandler: { result in
           switch result {
           case let .success(responce):
               guard let data = responce.data else {
                   completionHandler(.failure("Cann't get movies data matching query"))
                   return
               }
               completionHandler(.success(data.toDomain()))
           case let .failure(error):
               completionHandler(.failure(error))
           }
       })
    }
    
    func getMovieDetailsBtID(movieId: Int,
                             completionHandler: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        
        moviesLocalDataService.fetchMovieById(movieId,
                                              completionHandler: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    completionHandler(.success(response))
                }
            case .failure:
                self.moviesRemoteDataService.getMovieDetails(movieId: movieId) { result in
                    switch result {
                    case let .success(response):
                        guard let data = response.data else {
                            completionHandler(.failure("Cann't get movies data matching query"))
                            return
                        }
                        completionHandler(.success(data.toDomain()))
                        
                        //cache response
                        if let movieDetailsData = data.movies?.first {
                            self.moviesLocalDataService.saveMovieDetails(movieDetails: movieDetailsData)
                        }
                    case let .failure(error):
                        completionHandler(.failure(error))
                    }
                }
            }
        })
    }
}
