//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator
import RxCocoa


class ArticlesViewModel: ArticlesViewModelType, ArticlesViewModelInput, ArticlesViewModelOutput{
    var viewLoaded: PublishSubject<Void>
    
    var data: Observable<[ArticleViewModel]>
    
    // MARK: - Dependancies
    private var router: UnownedRouter<AppStartupRoute>
    private let articlesRepository: ArticleRepository
    
    init(router: UnownedRouter<AppStartupRoute>, articlesRepository: ArticleRepository) {
        
        /// Init Dependancies
        self.router = router
         self.articlesRepository = articlesRepository
        
        /// Init Inputs
        self.viewLoaded = PublishSubject<Void>().asObserver()
        
        let loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
        data = loadedData.asObservable()
        
        self.data = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
            return self.articlesRepository.fetchTopHeadlines(country: "us", category: "sports").map { $0.map{ ArticleViewModel(article: $0) }}
        })
        
    }
}
