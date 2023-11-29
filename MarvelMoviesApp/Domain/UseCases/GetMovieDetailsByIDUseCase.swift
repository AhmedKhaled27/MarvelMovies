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
    //MARK: Properites
    private var movieRepository: MovieRepository
    
    //MARK: Initializer
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
}

//MARK: conform to GetMoviesList
extension GetMovieDetailsByIDUseCase: GetMovieDetailsByID {
    func execute(movieId: Int, completionHandler: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        movieRepository.getMovieDetailsBtID(movieId: movieId,
                                            completionHandler: completionHandler)
    }
}

