//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class ArticleCell: UITableViewCell {
    
    //MARK:- OUTLET
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var puplishedDateLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var tilteView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var viewModel: ArticleViewModel!
    weak var delegate: FavoriteArticleDelegate?
    
    // MARK: - Methods
    func configCellAppearnce(with viewModel: ArticleViewModel) {
         self.viewModel = viewModel
        posterImageView.makeRoundedCorners(with: 30)
        container.makeRoundedCorners(with: 20)
        tilteView.makeRoundedCorners(with: 20)
        posterImageView.kf.setImage(with: URL.init(string: viewModel.posterImageURL ), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
        ])
        
        if viewModel.isFavoutie {
            self.favouriteButton.setImage(UIImage(named: "saved"), for: .normal)
        } else {
            self.favouriteButton.setImage(UIImage(named: "save"), for: .normal)
        }
        self.headLineLabel.text = viewModel.headline
        self.sourceNameLabel.text = viewModel.sourceName
        self.puplishedDateLabel.text = formatDate(with: viewModel.date)
    }
    
    private func formatDate(with stringDate: String) -> String {
        let date = DateConvertor.shared.getConverted(dateString: stringDate, fromFormat: .yyyyMMddTHHmmssZ, toFormat: .MMMdyyyyhmma)
        return date
    }

    //MARK:- ACTION
    @IBAction func didTapSave(_ sender: Any) {
        viewModel.isFavoutie = !viewModel.isFavoutie
        if viewModel.isFavoutie {
            favouriteButton.setImage( UIImage(named: "saved"), for: .normal)
            self.delegate?.saveArticle(model: self.viewModel)
        } else {
            favouriteButton.setImage(UIImage(named: "save"), for: .normal)
            self.delegate?.removeArticle(model: self.viewModel)
        }
    }
}

protocol FavoriteArticleDelegate: class {
    func saveArticle(model: ArticleViewModel)
    func removeArticle(model: ArticleViewModel)
}
