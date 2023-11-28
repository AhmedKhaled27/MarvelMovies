//
//  MoviesRemoteDataService.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

class MoviesRemoteDataService: APIService<MoviesEndPoint>, MoviesRemoteDataServiceProtocol {
    //MARK: Properites
    private let moviesLimt = 15
    
    func getMoviesList(page: Int,
                       completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void)) {
        let offset = page == 1 ? 0 : (page * moviesLimt)
        request(target: .moviesList(limit: moviesLimt, offset: offset),
                objType: BaseResponse<MoviesDataResponse>.self,
                completionHandler: completionHandler)
    }
    
    func searchMovies(page: Int, searchKey: String, completionHandler: @escaping ((Result<BaseResponse<MoviesDataResponse>, Error>) -> Void)) {
        let offset = page == 1 ? 0 : (page * moviesLimt)
        request(target: .searchMovies(limit: moviesLimt, offset: offset, searchKey: searchKey),
                objType: BaseResponse<MoviesDataResponse>.self,
                completionHandler: completionHandler)
    }
}
