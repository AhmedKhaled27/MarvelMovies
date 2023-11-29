//
//  MoviesRemoteDataServiceProtocol.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

protocol MoviesRemoteDataServiceProtocol {
    func getMoviesList(page: Int,
                       completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void))
    func searchMovies(page: Int,
                      searchKey: String,
                      completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void))
    func getMovieDetails(maovieId: Int,
                         completionHandler: @escaping ((Result<BaseResponse<MovieDetailsResponse>, Error>) -> Void))
}
