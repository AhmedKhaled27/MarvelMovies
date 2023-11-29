//
//  MovieDetailsData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation
import CoreData

struct MovieDetailsData: Codable {
    var id: Int?
    var description: String?
    var creators: MovieCreatorsData?
}

extension MovieDetailsData {
    func toDomain() -> MovieDetails {
        return MovieDetails(id: id,
                            description: description,
                            creators: creators?.toDomain())
    }
}

extension MovieDetailsData {
    func toEntity(in context: NSManagedObjectContext) -> MovieDetailsEntity {
        let entity: MovieDetailsEntity = .init(context: context)
        entity.id = Int64(id!)
        entity.movieDescription = description
        creators?.creators?.forEach({ creator in
            entity.addToCreators(creator.toEntity(in: context))
        })
        return entity
    }
}
