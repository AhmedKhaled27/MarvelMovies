//
//  MoviesEndPoint.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation
import Moya

enum MoviesEndPoint {
    case moviesList(limit: Int, offset: Int)
    case searchMovies(limit: Int, offset: Int, searchKey: String)
    case movieDetails(movieId: Int)
}

extension MoviesEndPoint: TargetType {
    var baseURL: URL { MarvelAPI.baseURL }
    
    var path: String {
        switch self {
        case .moviesList, .searchMovies: return "/v1/public/series"
        case let .movieDetails(movieId): return "/v1/public/series/\(movieId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .moviesList: return .get
        case .searchMovies: return .get
        case .movieDetails: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .moviesList(limit, offset):
            var params = MarvelAPI.defaultParameters
            params.updateValue(limit, forKey: "limit")
            params.updateValue(offset, forKey: "offset")
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
            
        case let .searchMovies(limit, offset, searchKey):
            var params = MarvelAPI.defaultParameters
            params.updateValue(limit, forKey: "limit")
            params.updateValue(offset, forKey: "offset")
            params.updateValue(searchKey, forKey: "titleStartsWith")
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
            
        case .movieDetails:
            let params = MarvelAPI.defaultParameters
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
}
