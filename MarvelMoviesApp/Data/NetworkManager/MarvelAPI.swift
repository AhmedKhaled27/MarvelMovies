//
//  MarvelAPI.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

struct MarvelAPI {
    
    static var baseURL: URL {
        URL(string: "https://gateway.marvel.com:443")!
    }
    
    static var defaultParameters: [String : Any] {
        let apiKey: String = "ca0fb9e22be0511b78e7a0cf6e644fb6"
        let privateKey: String =
           "4e77f28a353ba00ed169e38d2ff64a22a44136cf"
        let timestamp: String = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5
    
        return [
            "ts": timestamp,
            "hash": hash,
            "apikey": apiKey
        ]
    }

}
