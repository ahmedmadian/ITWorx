//
//  ArticlesRemoteServiceProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol ArticlesRemoteServiceProtocol {
    func fethcTopHeadlines(country: String, category: String) -> Observable<[Article]>
}

extension ArticlesRemoteService: ArticlesRemoteServiceProtocol {
    
    //MARK:- Properties
    static let shared = ArticlesRemoteService()
    
    func fethcTopHeadlines(country: String, category: String) -> Observable<[Article]> {
        let endPoint = ArticlesRemoteService.NewsAPIEndpoints.topHeadlines(country: country, categories: category)
        
        return Observable.create { observer in
            self.execute(endPoint: endPoint, parameters: endPoint.parameters) { (result: Result<ArticlesWrapper, Error> ) in
                switch result {
                case .success(let response):
                    observer.on(.next(response.articles))
                    observer.on(.completed)
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
        
    }
}
