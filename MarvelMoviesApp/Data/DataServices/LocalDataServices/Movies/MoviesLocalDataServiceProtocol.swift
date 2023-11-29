//
//  MoviesLocalDataServiceProtocol.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

protocol MoviesLocalDataServiceProtocol {
    func fetchMovieById(_ id: Int,
                        completionHandler: @escaping (Result<MovieDetails, Error>) -> Void)
    func saveMovieDetails(movieDetails: MovieDetailsData)
}
