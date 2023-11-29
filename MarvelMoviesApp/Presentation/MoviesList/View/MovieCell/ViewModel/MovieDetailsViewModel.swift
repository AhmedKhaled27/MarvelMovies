//
//  MovieDetailsViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct MovieDetailsViewModel {
    var description: String?
    var numberOfCreators: Int { creators.count }
    private var creators: [Creator] = []
    private var creatorCellViewModel: [CreatorCellViewModel] {
        creators.map({ CreatorCellViewModel(creator: $0) })
    }
    
    init(movieDetails: MovieDetails) {
        self.description = movieDetails.descroption
        self.creators = movieDetails.creators ?? []
    }
}

extension MovieDetailsViewModel {
    func getCreatorItemCellViewModel(atIndex index: Int) -> CreatorCellViewModel {
        return creatorCellViewModel[index]
    }
}
