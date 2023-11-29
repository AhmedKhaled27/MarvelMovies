//
//  MovieData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MovieData: Codable {
    var id: Int?
    var name: String?
    var image: MovieImageData?
    var rating: String?
    var startYear: Int?
    var endYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case rating
        case startYear
        case endYear
        case name = "title"
        case image = "thumbnail"
    }
    
}

extension MovieData {
    func toDomain() -> Movie {
        Movie(id: id, name: name, image: image?.toDomain(), rating: rating, startYear: startYear, endYear: endYear)
    }
}
