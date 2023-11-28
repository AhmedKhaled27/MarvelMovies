//
//  MovieImageData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MovieImageData: Codable {
    var url: String?
    var imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "path"
        case imageExtension = "extension"
    }
}

extension MovieImageData {
    func toDomain() -> MovieImage {
        MovieImage(url: url,
                   imageExtension: imageExtension)
    }
}
