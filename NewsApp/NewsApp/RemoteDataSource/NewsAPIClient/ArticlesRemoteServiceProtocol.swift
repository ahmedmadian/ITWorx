//
//  ArticlesRemoteServiceProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol ArticlesRemoteServiceProtocol {
    func fethcTopHeadlines(country: String, category: String, completion: @escaping([Article]?, Error?) -> Void)
}

extension ArticlesRemoteService: ArticlesRemoteServiceProtocol {
    func fethcTopHeadlines(country: String, category: String, completion: @escaping ([Article]?, Error?) -> Void) {
        let endPoint = ArticlesRemoteService.NewsAPIEndpoints.topHeadlines(country: country, categories: category)
       
        self.execute(endPoint: endPoint, parameters: endPoint.parameters) { (result: Result<ArticlesWrapper, Error>) in
            switch result {
            case .success(let response) :
                completion(response.articles, nil)
            case .failure(let error) :
                completion(nil, error)
            }
        }
    }
    
    
}
