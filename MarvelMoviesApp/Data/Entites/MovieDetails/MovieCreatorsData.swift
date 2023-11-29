//
//  MovieCreatorsData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct MovieCreatorsData: Codable {
    let creators: [CreatorData]?
    
    enum CodingKeys: String, CodingKey {
        case creators = "items"
    }
}

extension MovieCreatorsData {
    func toDomain() -> [Creator]? {
        creators?.map({ $0.toDomain() })
    }
}
