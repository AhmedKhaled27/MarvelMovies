//
//  MovieDetailsResponse.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct MovieDetailsResponse: Codable {
    var movies: [MovieDetailsData]?
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

extension MovieDetailsResponse {
    func toDomain() -> MovieDetails {
        return movies?.first?.toDomain() ?? MovieDetails()
    }
}

