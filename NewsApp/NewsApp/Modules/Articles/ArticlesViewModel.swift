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
import CoreData

class ArticlesViewModel: ArticlesViewModelType, ArticlesViewModelInput, ArticlesViewModelOutput{
    
    var viewLoaded: PublishSubject<Void>
    var articleSelected: PublishSubject<ArticleViewModel>
    var saveArticle: PublishSubject<ArticleViewModel>
    var removeArticle: PublishSubject<ArticleViewModel>
    
    var data: Observable<[ArticleViewModel]>
    var loading: Observable<Bool>
    var errorMessage: PublishSubject<String>
    var title: Observable<String>
    
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
        self.articleSelected = PublishSubject<ArticleViewModel>().asObserver()
        saveArticle = PublishSubject<ArticleViewModel>().asObserver()
        removeArticle = PublishSubject<ArticleViewModel>().asObserver()
        
        ///Init Output
        data = Observable.empty()
        self.title = Observable.empty()
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        errorMessage = PublishSubject<String>()
        
        
//        let categoryOne = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
//            let items = Favourite.getAllSortedByDate(context: CoreDataManager.shared.managedContext)
//            return self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: Settings.shared.categories[0]).map{ $0.map {ArticleViewModel(article: $0)}}
//        })
//
//        let categoryTwo = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
//            return self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: Settings.shared.categories[1]).map{ $0.map {ArticleViewModel(article: $0)}}
//        })
//
//        let categoryThree = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
//            return self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: Settings.shared.categories[2]).map{ $0.map {ArticleViewModel(article: $0)}}
//        })
        
        
        //self.data = Observable.combineLatest(categoryOne, categoryTwo, categoryThree)
            //.trackActivity(activityIndicator)
            
        
        
      
        
        
        self.data = viewLoaded.flatMapLatest({ _ -> Observable<[ArticleViewModel]> in
            let items = Favourite.getAllSortedByDate(context: CoreDataManager.shared.managedContext)
            let res = self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: "sports").map { $0.map{ article -> ArticleViewModel in
                let viewModel = ArticleViewModel(article: article)
                viewModel.isFavoutie = items.contains{ $0.url == viewModel.url }
                return viewModel }}
            return res
        }).catchError{ error in
            self.errorMessage.onNext(error.localizedDescription)
            return Observable.empty()
        }.trackActivity(activityIndicator)
        
        
        self.title = viewLoaded.flatMapLatest({_ -> Observable<String> in
            return Observable.just(Settings.shared.countryName!)
        })
        
        _ = articleSelected.subscribe(onNext: {
            if let url = URL(string: $0.url) {
                router.trigger(.safari(url: url))
            }
        })
        
        _ = saveArticle.subscribe(onNext: {
            self.favoritesRepository.addToFavourites(imageURL: $0.posterImageURL, title: $0.headline, url: $0.url, date: Date())
            })
        
        _ = removeArticle.subscribe(onNext: {
            self.favoritesRepository.remove(url: $0.url)
        })
        
    }
}
