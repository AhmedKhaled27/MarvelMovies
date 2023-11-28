//
//  AppColors.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import UIKit

enum AppColors: String {
    case color_D83933
}

extension AppColors {
    var color: UIColor {
        return UIColor(named: rawValue) ?? .black
    }
}
