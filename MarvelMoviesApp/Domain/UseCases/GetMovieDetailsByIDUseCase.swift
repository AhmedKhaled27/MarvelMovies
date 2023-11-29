//
//  GetMovieDetailsByID.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

protocol GetMovieDetailsByID {
    func execute(movieId: Int,
                 completionHandler: @escaping ((Result<MovieDetails, Error>) -> Void) )
}

class GetMovieDetailsByIDUseCase {
    //MARK: Properties
    private lazy var movieRepository: MovieRepository = MovieDataRepository()
}

//MARK: conform to GetMoviesList
extension GetMovieDetailsByIDUseCase: GetMovieDetailsByID {
    func execute(movieId: Int, completionHandler: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        movieRepository.getMovieDetailsBtID(movieId: movieId,
                                            completionHandler: completionHandler)
    }
}

