//
//  GetMoviesListUseCase.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

protocol GetMoviesList {
    func execute(page: Int,
                completionHandler: @escaping ((Result<Movies, Error>) -> Void) )
}

class GetMoviesListUseCase {
    //MARK: Properites
    private var movieRepository: MovieRepository
    
    //MARK: Initializer
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
}

//MARK: conform to GetMoviesList
extension GetMoviesListUseCase: GetMoviesList {
    func execute(page: Int, completionHandler: @escaping ((Result<Movies, Error>) -> Void)) {
        movieRepository.getMoviesList(page: page,
                                      completionHandler: completionHandler)
    }
}
