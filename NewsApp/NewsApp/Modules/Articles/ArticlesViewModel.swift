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
    var articleSelected: PublishSubject<ArticleViewModel>
      
    var data: Observable<[ArticleViewModel]>
    
    // MARK: - Dependancies
    private var router: UnownedRouter<NewsFeedRoute>
    private let articlesRepository: ArticleRepository
    
    init(router: UnownedRouter<NewsFeedRoute>, articlesRepository: ArticleRepository) {
        
        /// Init Dependancies
        self.router = router
         self.articlesRepository = articlesRepository
        
        /// Init Inputs
        self.viewLoaded = PublishSubject<Void>().asObserver()
        
        let loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
        data = loadedData.asObservable()
        
        self.articleSelected = PublishSubject<ArticleViewModel>().asObserver()
        
        self.data = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
            return self.articlesRepository.fetchTopHeadlines(country: "eg", category: "sports").map { $0.map{ ArticleViewModel(article: $0) }}
        })
        
        _ = articleSelected.subscribe(onNext: {
            if let url = URL(string: $0.url) {
                router.trigger(.safari(url: url))
            }
        })
        
    }
}
