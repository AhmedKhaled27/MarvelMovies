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
    var numberOfItems: Int {get}
    var selectedMovieIndex: Observable<Int> {get set}
        //SearchBar
    var searchKey: Observable<String> {get set}
    
    //Functions
    func viewDidLoad()
        //TableView
    func getMovieCellViewModel(forCellAtIndex index: Int) -> MovieCellViewModel?
    func getMovieDetailsViewModel(forMovieAtIndex index: Int,
                                  completionHander: @escaping (MovieDetailsViewModel?) -> Void)
    func loadMoreMovies()
    func didSelectMovieCell(atIndex index: Int)
        //SearchBar
    func didSearch(searchKey: String)
    func setSearchingIsEnabled(_ isEnabled: Bool)
}
