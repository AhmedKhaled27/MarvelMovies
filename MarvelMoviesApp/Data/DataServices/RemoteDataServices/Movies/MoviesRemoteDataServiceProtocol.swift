//
//  MoviesRemoteDataServiceProtocol.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation
import Moya

protocol MoviesRemoteDataServiceProtocol {
    func getMoviesList(page: Int,
                       completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void)) -> Cancellable
    func searchMovies(page: Int,
                      searchKey: String,
                      completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void)) -> Cancellable
    func getMovieDetails(movieId: Int,
                         completionHandler: @escaping ((Result<BaseResponse<MovieDetailsResponse>, Error>) -> Void))
}
