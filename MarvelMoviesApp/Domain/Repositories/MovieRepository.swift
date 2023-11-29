//
//  MovieRepository.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

protocol MovieRepository {
    func getMoviesList(page: Int,
                       completionHandler: @escaping ((Result<Movies, Error>) -> Void))
    func searchMovies(page: Int,
                      searchKey: String,
                      completionHandler: @escaping ((Result<Movies, Error>) -> Void))
    func getMovieDetailsBtID(movieId: Int,
                             completionHandler: @escaping ((Result<MovieDetails, Error>) -> Void))
}
