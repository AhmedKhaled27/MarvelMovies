//
//  MovieDetailsViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation

struct MovieDetailsViewModel {
    var id: Int?
    
    init(movieDetails: MovieDetails) {
        self.id = movieDetails.id
    }
}
