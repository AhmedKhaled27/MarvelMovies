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
            containerView.layer.cornerRadius = containerView.frame.height/8
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.red.cgColor
        }
    }
    @IBOutlet weak var moviewImageView: UIImageView! {
        didSet {
            moviewImageView.layer.cornerRadius = moviewImageView.frame.height/8
            moviewImageView.layer.borderWidth = 1
            moviewImageView.layer.borderColor = UIColor.red.cgColor
        }
    }
    
}
