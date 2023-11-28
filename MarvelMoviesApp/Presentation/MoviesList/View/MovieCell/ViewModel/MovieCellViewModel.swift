//
//  MovieCellViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MovieCellViewModel {
    var movieName: String?
    var movieThumbnailURL: URL?
    var data: Int?
    var rating: String?
    
    init(movie: Movie) {
        self.movieName = movie.name
        self.movieThumbnailURL = movie.image?.imageURL
        self.data = movie.startYear
        self.rating = movie.rating
    }
}
