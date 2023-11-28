//
//  MovieImage.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MovieImage {
    private var url: String?
    private var imageExtension: String?

    var imageURL: URL? {
        guard let url = url,
              let imageExtension = imageExtension,
              !url.isEmpty, !imageExtension.isEmpty else { return nil }
        let stringURL = "\(url).\(imageExtension)"
        return URL(string: stringURL)
    }
    
    init(url: String?,
         imageExtension: String?) {
        self.url = url
        self.imageExtension = imageExtension
    }
}
