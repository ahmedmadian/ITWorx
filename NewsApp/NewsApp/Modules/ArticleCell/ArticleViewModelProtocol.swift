//
//  ArticleViewModelProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticleViewModelInput {
    var didTapSave: PublishSubject<Void> { get }
}

protocol ArticleViewModelOutput {
    var headLine: BehaviorSubject<String> { get }
    var sourceName: BehaviorSubject<String> { get }
    var date: BehaviorSubject<String> { get }
    var imageURL: BehaviorSubject<String> { get }
    var isFavourite: BehaviorRelay<Bool> { get }
    
}

protocol ArticleViewModelType {
    var input: ArticleViewModelInput { get }
    var output: ArticleViewModelOutput { get }
}

extension ArticleViewModelType where Self: ArticleViewModelInput & ArticleViewModelOutput {
    var input: ArticleViewModelInput { return self }
    var output: ArticleViewModelOutput { return self }
}
