//
//  CreatorCell.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import UIKit

class CreatorCell: UICollectionViewCell {
    //MARK: OutLets
    @IBOutlet weak var containerView: UIView!{
        didSet {
            containerView.layer.borderColor = AppColors.color_D83933.color.cgColor
            containerView.layer.borderWidth = 1
            containerView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var creatorNameLabel: UILabel!
    @IBOutlet weak var creatorRoleLabel: UILabel!
    
    //MARK: Properites
    var viewModel: CreatorCellViewModel? {
        didSet { setupViewModel() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    //MARK: Helper Functions
    private func setupViewModel() {
        guard let viewModel = viewModel else {return}
        creatorNameLabel.text = viewModel.name ?? ""
        creatorRoleLabel.text = viewModel.role ?? ""
    }
}
