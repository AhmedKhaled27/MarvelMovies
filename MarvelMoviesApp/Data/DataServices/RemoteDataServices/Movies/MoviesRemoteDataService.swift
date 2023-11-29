//
//  MoviesRemoteDataService.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

class MoviesRemoteDataService: APIService<MoviesEndPoint>, MoviesRemoteDataServiceProtocol {
    //MARK: Properties
    private let moviesLimit = 15
    
    func getMoviesList(page: Int,
                       completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void)) {
        let offset = page == 1 ? 0 : (page * moviesLimit)
        request(target: .moviesList(limit: moviesLimit, offset: offset),
                objType: BaseResponse<MoviesDataResponse>.self,
                completionHandler: completionHandler)
    }
    
    func searchMovies(page: Int, searchKey: String, completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void)) {
        let offset = page == 1 ? 0 : (page * moviesLimit)
        request(target: .searchMovies(limit: moviesLimit, offset: offset, searchKey: searchKey),
                objType: BaseResponse<MoviesDataResponse>.self,
                completionHandler: completionHandler)
    }
    
    func getMovieDetails(movieId: Int, completionHandler: @escaping ((Result<BaseResponse<MovieDetailsResponse>, Error>) -> Void)) {
        request(target: .movieDetails(movieId: movieId), objType: BaseResponse<MovieDetailsResponse>.self,
                completionHandler: completionHandler)
    }
    
}
