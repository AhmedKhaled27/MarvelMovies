//
//  MoviesListViewModelProtocol.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

protocol MoviesListViewModelProtocol {
    //Properites
    var loading: Observable<MoviesListViewModelLoading> {get set}
    var moviesResponseState: Observable<GetMoviesResponseState> {get set}
        //TableViewDataSource
    var moviesCellsViewModels: Observable<[MovieCellViewModel]> {get set}
    var numberOfItems: Int {get}
    
    //Functions
    func viewDidLoad()
        //TableView
    func getMovieCellViewModel(forCellAtIndex index: Int) -> MovieCellViewModel?
    func loadMoreMovies()
}
