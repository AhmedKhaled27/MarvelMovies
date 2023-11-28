//
//  MovieCellTableViewCell.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import UIKit

class MovieCellTableViewCell: UITableViewCell {
    //MARK: IBOutLets
    @IBOutlet private var containerView: UIStackView! {
        didSet {
            containerView.layer.cornerRadius = thumbnailImageView.frame.height/8
            containerView.layer.borderColor = UIColor.red.cgColor
            containerView.layer.borderWidth = 1
        }
    }
    @IBOutlet private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.height/8
            thumbnailImageView.layer.borderColor = UIColor.red.cgColor
            thumbnailImageView.layer.borderWidth = 1
        }
    }
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    //MARK: Properites
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
