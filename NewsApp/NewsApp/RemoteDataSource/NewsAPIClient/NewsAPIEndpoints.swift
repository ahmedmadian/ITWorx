//
//  NewsAPIEndpoints.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum NewsAPIEndpoints: Endpointable {
   
    case topHeadlines(country: String, categories: [String])
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var name: String {
        switch self {
        case .topHeadlines(_,_):
            return "top-headlines"
        }
    }
    
    var parameters: [String : Any] {
           return ["":""]
    }
}
