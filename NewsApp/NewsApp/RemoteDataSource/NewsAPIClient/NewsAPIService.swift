//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol NewsAPIServiceable: BaseAPIServiceProtocol {
    func fethcTopHeadlines(completion: @escaping([Article]?, Error?) -> Void)
}

class NewsAPI: NewsAPIServiceable {
    func fethcTopHeadlines(completion: @escaping ([Article]?, Error?) -> Void) {
       
    }
}


// MARK: - Home
struct GlobalResponse<T>: Codable where T: Codable {
    let status: String
    let totalResults: Int
    let articles: [T]
}
