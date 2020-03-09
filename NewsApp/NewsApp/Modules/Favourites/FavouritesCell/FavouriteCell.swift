//
//  FavouriteCell.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var posteView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - METHODS
    func configCellAppearnce(with viewModel: FavouriteViewModel) {
        posteView.kf.setImage(with: URL.init(string: viewModel.imageURL), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        self.titleLabel.text = viewModel.title
    }
}
