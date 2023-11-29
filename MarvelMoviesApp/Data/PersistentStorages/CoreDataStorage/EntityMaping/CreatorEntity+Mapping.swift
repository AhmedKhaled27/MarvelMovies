//
//  CreatorEntity+Mapping.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

extension CreatorEntity {
    func toDomain() -> Creator {
        Creator(name: name, role: role)
    }
}
