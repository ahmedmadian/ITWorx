//
//  TagCell.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/9/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TagCell: UICollectionViewCell, BindableType {
    
    // MARK: OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - DEPENDENCIES
    var viewModel: TagViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        configCellAppearnce()
    }
    
    // MARK: - METHODS
    func bindViewModel() {
        
        /// OUTPUT
        titleLabel.text = viewModel.output.title
        viewModel.output.isSelected.subscribe(onNext: {
            self.borderView.isHidden = !$0
        }).disposed(by: disposeBag)
        
    }
    
    private func configCellAppearnce() {
        containerView.makeRoundedCorners(with: containerView.frame.height / 8)
        borderView.makeRoundedCorners(with: borderView.frame.height/8)
        innerView.makeRoundedCorners(with: borderView.frame.height/8)
        imageView.makeRoundedCorners(with: imageView.frame.height / 8)
        animateCell()
    }
    
    private func animateCell() {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        self.layer.transform = rotationTransform
        self.alpha = 0.5
        UIView.animate(withDuration: 1.0) {
            self.layer.transform = CATransform3DIdentity
            self.alpha = 1.0
        }
    }
}
