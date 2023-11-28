//
//  SearchMoviesUseCase.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

protocol SearchMovies {
    func execute(page: Int,
                 searchKey: String,
                 completionHandler: @escaping ((Result<Movies, Error>) -> Void) )
}

class SearchMoviesUseCase {
    //MARK: Properites
    private var movieRepository: MovieRepository
    
    //MARK: Initializer
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
}

//MARK: conform to GetMoviesList
extension SearchMoviesUseCase: SearchMovies {
    func execute(page: Int, searchKey: String, completionHandler: @escaping ((Result<Movies, Error>) -> Void)) {
        movieRepository.searchMovies(page: page,
                                     searchKey: searchKey,
                                     completionHandler: completionHandler)
    }
}
