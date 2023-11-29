//
//  CreatorData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation
import CoreData

struct CreatorData: Codable {
    var name: String?
    var role: String?
}

extension CreatorData {
    func toDomain() -> Creator {
        Creator(name: name, role: role)
    }
}

extension CreatorData {
    func toEntity(in context: NSManagedObjectContext) -> CreatorEntity  {
        let entity: CreatorEntity = .init(context: context)
        entity.name = name
        entity.role = role
        return entity
    }
}
