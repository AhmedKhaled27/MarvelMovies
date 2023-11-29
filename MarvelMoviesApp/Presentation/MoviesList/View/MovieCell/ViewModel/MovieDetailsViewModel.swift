//
//  MovieDetailsViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct MovieDetailsViewModel {
    var description: String?

    
    init(movieDetails: MovieDetails) {
        self.description = movieDetails.descroption
    }
}
