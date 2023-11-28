//
//  BaseResponse.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation

public struct BaseResponse<C: Codable>: Codable {
    let data: C?
}
