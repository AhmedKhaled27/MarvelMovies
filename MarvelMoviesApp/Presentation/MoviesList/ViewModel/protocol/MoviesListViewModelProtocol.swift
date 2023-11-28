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
    
    //Functions
    func viewDidLoad()
}
