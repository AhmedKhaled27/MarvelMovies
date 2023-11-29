//
//  MovieDetailsEntity+Mapping.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

extension MovieDetailsEntity {
    func toDomain() -> MovieDetails {
        MovieDetails(id: Int(id),
                     descroption: movieDescription,
                     creators: creators?.allObjects.map({ ($0 as! CreatorEntity).toDomain() }))
    }
}
