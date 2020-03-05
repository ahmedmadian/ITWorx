//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var puplishedDateLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var tilteView: UIView!
    
    // MARK: - Methods
    func configCellAppearnce(with viewModel: ArticleViewModel) {
        posterImageView.makeRoundedCorners(with: 30)
        container.makeRoundedCorners(with: 20)
        tilteView.makeRoundedCorners(with: 20)
        posterImageView.kf.setImage(with: URL.init(string: viewModel.posterImageURL ), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        self.headLineLabel.text = viewModel.headline
        self.sourceNameLabel.text = viewModel.sourceName
        self.puplishedDateLabel.text = formatDate(with: viewModel.date)
    }
    
    private func formatDate(with stringDate: String) -> String {
        let date = DateConvertor.shared.getConverted(dateString: stringDate, fromFormat: .yyyyMMddTHHmmssZ, toFormat: .MMMdyyyyhmma)
        return date
    }

}
