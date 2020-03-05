//
//  ArticlesRepository.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol ArticleRepository {
    func fetchTopHeadlines(country: String, category: String) -> Observable<[Article]>
}

class ArticlesDataRepository: ArticleRepository{
    
    
    //MARK:- Properties
    private let remoteDataSource: ArticlesRemoteServiceProtocol
    
    // MARK:- Initializers
    init(remoteDataSource: ArticlesRemoteServiceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    //MARK:- Methods
    func fetchTopHeadlines(country: String, category: String) -> Observable<[Article]> {
        return self.remoteDataSource.fethcTopHeadlines(country: country, category: category)
    }
}
