//
//  MovieImageData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MovieImageData: Codable {
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "path"
    }
}

extension MovieImageData {
    func toDomain() -> MovieImage {
        MovieImage(url: url)
    }
}
