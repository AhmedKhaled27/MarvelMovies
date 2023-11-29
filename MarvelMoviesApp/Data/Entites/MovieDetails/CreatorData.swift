//
//  CreatorData.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct CreatorData: Codable {
    var name: String?
    var role: String?
}

extension CreatorData {
    func toDomain() -> Creator {
        Creator(name: name, role: role)
    }
}
