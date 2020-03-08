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
    var saveArticle: PublishSubject<ArticleViewModel>
    var removeArticle: PublishSubject<ArticleViewModel>
    
    var data: Observable<[ArticleViewModel]>
    var loading: Observable<Bool>
    var errorMessage: PublishSubject<String>
    
    // MARK: - Dependancies
    private var router: UnownedRouter<NewsFeedRoute>
    private let articlesRepository: ArticleRepository
    private let favoritesRepository: FavouritesRepositoryProtocol
    
    init(router: UnownedRouter<NewsFeedRoute>, articlesRepository: ArticleRepository, favoritesRepository: FavouritesRepositoryProtocol) {
        
        /// Init Dependancies
        self.router = router
        self.articlesRepository = articlesRepository
        self.favoritesRepository = favoritesRepository
        
        /// Init Inputs
        self.viewLoaded = PublishSubject<Void>().asObserver()
        
        let loadedData = BehaviorRelay<[ArticleViewModel]>(value: [])
        data = loadedData.asObservable()
        
        self.articleSelected = PublishSubject<ArticleViewModel>().asObserver()
        
        saveArticle = PublishSubject<ArticleViewModel>().asObserver()
        removeArticle = PublishSubject<ArticleViewModel>().asObserver()
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        
        errorMessage = PublishSubject<String>()
        
        self.data = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
            return self.articlesRepository.fetchTopHeadlines(country: "ar", category: "sports").map { $0.map{ ArticleViewModel(article: $0) }}
        }).catchError{ error in
            self.errorMessage.onNext(error.localizedDescription)
            return Observable.empty()
        }.trackActivity(activityIndicator)
        
        _ = articleSelected.subscribe(onNext: {
            if let url = URL(string: $0.url) {
                router.trigger(.safari(url: url))
            }
        })
        
        _ = saveArticle.subscribe(onNext: {
            let favorite = Favourite(imageURL: $0.posterImageURL, url: $0.url, title: $0.headline, date: Date())
            self.favoritesRepository.addToFavourites(favourite: favorite)
            })
        
        _ = removeArticle.subscribe(onNext: {
            let favorite = Favourite(imageURL: $0.posterImageURL, url: $0.url, title: $0.headline, date: Date())
            self.favoritesRepository.remove(favorite: favorite)
        })
        
    }
}
