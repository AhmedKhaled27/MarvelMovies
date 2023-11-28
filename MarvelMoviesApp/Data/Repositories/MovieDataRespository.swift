//
//  MovieDataRespository.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

class MovieDataRespository {
    //MARK: Properites
    let moviesRemoteDataService: MoviesRemoteDataServiceProtocol
    
    //MARK: Initialization
    init(moviesRemoteDataService: MoviesRemoteDataServiceProtocol) {
        self.moviesRemoteDataService = moviesRemoteDataService
    }
}

//MARK: Conform to MovieRepository
extension MovieDataRespository: MovieRepository {
    func getMoviesList(page: Int, completionHandler: @escaping ((Result<Movies, Error>) -> Void)) {
        moviesRemoteDataService.getMoviesList(page: page,
                                              completionHandler: { result in
            switch result {
            case let .success(responce):
                guard let data = responce.data else {
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
}
