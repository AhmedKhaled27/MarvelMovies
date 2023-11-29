//
//  MovieCellViewModel.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

enum MovieCellState {
    case collapsed
    case expanded(isLoading:Bool)
}

struct MovieCellViewModel {
    var movieName: String?
    var movieThumbnailURL: URL?
    var data: Int?
    var rating: String?
    private(set) var cellState: MovieCellState = .collapsed
    var detailsViewModel: MovieDetailsViewModel?
    
    init(movie: Movie,
         detailsViewModel: MovieDetailsViewModel? = nil) {
        self.movieName = movie.name
        self.movieThumbnailURL = movie.image?.imageURL
        self.data = movie.startYear
        self.rating = movie.rating
        self.detailsViewModel = detailsViewModel
    }
    
    mutating func updateCellState(newState: MovieCellState) {
        self.cellState = newState
    }
}
