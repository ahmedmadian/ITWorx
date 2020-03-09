//
//  TagViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TagViewModel: TagViewModelType, TagViewModelInput, TagViewModelOutput {
   
    
    var title: String
    var isSelected: BehaviorRelay<Bool>
    
    init(with tag: Tag) {
        self.title = tag.name
        self.isSelected = BehaviorRelay<Bool>(value: tag.isPrefered)
    }
}
