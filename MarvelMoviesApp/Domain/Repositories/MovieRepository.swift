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
}
