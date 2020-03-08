//
//  ArticlesViewModelProtocols.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ArticlesViewModelInput {
    var viewLoaded: PublishSubject<Void> { get }
    var articleSelected: PublishSubject<ArticleViewModel> { get }
    var saveArticle: PublishSubject<ArticleViewModel> { get }
    var removeArticle: PublishSubject<ArticleViewModel> { get }
}

protocol ArticlesViewModelOutput {
    var data: Observable<[ArticleViewModel]> {get}
    var loading: Observable<Bool> { get }
    var errorMessage: PublishSubject<String> { get }
}

protocol ArticlesViewModelType {
    var input: ArticlesViewModelInput { get }
    var output: ArticlesViewModelOutput { get }
}

extension ArticlesViewModelType where Self: ArticlesViewModelInput & ArticlesViewModelOutput {
    var input: ArticlesViewModelInput { return self }
    var output: ArticlesViewModelOutput { return self }
}
