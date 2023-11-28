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
}

extension MoviesEndPoint: TargetType {
    var baseURL: URL { MarvelAPI.baseURL }
    
    var path: String {
        switch self {
        case .moviesList: return "/v1/public/series"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .moviesList: return .get
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
        }
    }
    
    var headers: [String : String]? { nil }
}
