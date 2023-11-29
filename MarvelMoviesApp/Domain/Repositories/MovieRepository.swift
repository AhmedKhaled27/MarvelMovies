//
//  MovieRepository.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation
import Moya

protocol MovieRepository {
    func getMoviesList(page: Int,
                       completionHandler: @escaping ((Result<Movies, Error>) -> Void)) -> Cancellable
    func searchMovies(page: Int,
                      searchKey: String,
                      completionHandler: @escaping ((Result<Movies, Error>) -> Void)) -> Cancellable
    func getMovieDetailsBtID(movieId: Int,
                             completionHandler: @escaping ((Result<MovieDetails, Error>) -> Void))
}
