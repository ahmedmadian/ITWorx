//
//  ArticlesWrapper.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

struct ArticlesWrapper: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
