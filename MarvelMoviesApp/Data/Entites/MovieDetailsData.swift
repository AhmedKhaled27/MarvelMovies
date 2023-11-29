//
//  MovieDetailsData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct MovieDetailsData: Codable {
    var id: Int?
    var description: String?
}

extension MovieDetailsData {
    func toDomain() -> MovieDetails {
        return MovieDetails(id: id, descroption: description)
    }
}
