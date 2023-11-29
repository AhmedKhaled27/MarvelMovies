//
//  MoviesDataResponse.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MoviesDataResponse: Codable {
    var total: Int?
    var movies: [MovieData]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case movies = "results"
    }
}

extension MoviesDataResponse {
    func toDomain() -> Movies {
        Movies(total: total,
               movies: movies?.map({ $0.toDomain() }))
    }
}
