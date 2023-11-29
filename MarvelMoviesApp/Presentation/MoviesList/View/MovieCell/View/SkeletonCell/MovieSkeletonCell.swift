//
//  MovieSkeletonCell.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import UIKit

class MovieSkeletonCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!{
        didSet {
            containerView.layer.cornerRadius = containerView.frame.height/5
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = AppColors.color_D83933.color.cgColor
        }
    }
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.layer.cornerRadius = movieImageView.frame.height/6
            movieImageView.layer.borderWidth = 1
            movieImageView.layer.borderColor = AppColors.color_D83933.color.cgColor
        }
    }
    
}
