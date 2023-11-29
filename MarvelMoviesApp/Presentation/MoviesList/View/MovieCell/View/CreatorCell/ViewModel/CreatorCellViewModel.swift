//
//  CreatorCellViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct CreatorCellViewModel {
    var name: String?
    var role: String?
    
    init(creator: Creator) {
        self.name = creator.name
        self.role = creator.role
    }
}
