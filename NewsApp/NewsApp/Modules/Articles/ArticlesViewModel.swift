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
    
    //MARK:- INPUT
    var viewLoaded: PublishSubject<Void>
    var articleSelected: PublishSubject<ArticleViewModel>
    var saveArticle: PublishSubject<ArticleViewModel>
    var removeArticle: PublishSubject<ArticleViewModel>
    
    //MARK:- OUTPUT
    var data: Observable<[ArticleViewModel]>
    var loading: Observable<Bool>
    var errorMessage: PublishSubject<String>
    var title: Observable<String>
    
    // MARK: - DEPENDENCIES
    private var router: UnownedRouter<NewsFeedRoute>
    private let articlesRepository: ArticleRepository
    private let favoritesRepository: FavouritesRepositoryProtocol
    
    init(router: UnownedRouter<NewsFeedRoute>, articlesRepository: ArticleRepository, favoritesRepository: FavouritesRepositoryProtocol) {
        
        /// init DEPENDENCIES
        self.router = router
        self.articlesRepository = articlesRepository
        self.favoritesRepository = favoritesRepository
        
        /// init INPUT
        self.viewLoaded = PublishSubject<Void>().asObserver()
        self.articleSelected = PublishSubject<ArticleViewModel>().asObserver()
        self.saveArticle = PublishSubject<ArticleViewModel>().asObserver()
        self.removeArticle = PublishSubject<ArticleViewModel>().asObserver()
        
        ///init OUTPUT
        data = Observable.empty()
        self.title = Observable.empty()
        
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        
        errorMessage = PublishSubject<String>()

        /// RequestGroup
        let firstCategory = viewLoaded.flatMapLatest({ _ -> Observable<[Article]> in
            return self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: Settings.shared.categories![0])
        }).trackActivity(activityIndicator)
        
        let secondCategory = viewLoaded.flatMapLatest({ _ -> Observable<[Article]> in
            return self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: Settings.shared.categories![0])
        }).trackActivity(activityIndicator)
            
        let thirdCategory = viewLoaded.flatMapLatest({ _ -> Observable<[Article]> in
            return self.articlesRepository.fetchTopHeadlines(country: Settings.shared.countryiso2!, category: Settings.shared.categories![1])
        }).trackActivity(activityIndicator)

        self.data = Observable.combineLatest(firstCategory, secondCategory, thirdCategory){ one,two,three  in
            let items = Favourite.getAllSortedByDate(context: CoreDataManager.shared.managedContext)
            let res =  (one + two + three).map { (article) -> ArticleViewModel in
                let viewModel = ArticleViewModel(article: article)
                viewModel.isFavoutie = items.contains{ $0.url == viewModel.url}
                return viewModel
            }
            return res
        }.catchError{ error in
            self.errorMessage.onNext(error.localizedDescription)
            return Observable.empty()
        }.trackActivity(activityIndicator)
        
        
        self.title = viewLoaded.flatMapLatest({_ -> Observable<String> in
            return Observable.just("\(Settings.shared.countryName!) News")
        })
        
        _ = saveArticle.subscribe(onNext: {
            self.favoritesRepository.addToFavourites(imageURL: $0.posterImageURL, title: $0.headline, url: $0.url, date: Date())
            })
        
        _ = removeArticle.subscribe(onNext: {
            self.favoritesRepository.remove(url: $0.url)
        })
        
        _ = articleSelected.subscribe(onNext: {
            if let url = URL(string: $0.url) {
                router.trigger(.safari(url: url))
            }
        })
        
    }
}
