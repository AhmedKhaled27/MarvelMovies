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
    //MARK: Properties
    private lazy var movieRepository: MovieRepository = MovieDataRepository()
}

//MARK: conform to GetMoviesList
extension GetMoviesListUseCase: GetMoviesList {
    func execute(page: Int, completionHandler: @escaping ((Result<Movies, Error>) -> Void)) {
        movieRepository.getMoviesList(page: page,
                                      completionHandler: completionHandler)
    }
}
