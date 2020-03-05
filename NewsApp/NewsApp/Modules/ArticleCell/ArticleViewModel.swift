//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
class ArticleViewModel {
    let posterImageURL: String
    let headline: String
    let date: String
    let authorName: String
    let articleDescription: String
    let url: String
    let sourceName: String
    
    init(article: Article) {
        self.posterImageURL = article.urlToImage
        self.headline = article.title
        self.date = article.publishedAt
        self.authorName = article.author ?? ""
        self.articleDescription = article.articleDescription
        self.url = article.url
        self.sourceName = article.source.name
    }
}
