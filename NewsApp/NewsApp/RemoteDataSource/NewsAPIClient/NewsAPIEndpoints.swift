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
    
    //MARK:- Properties
    var name: String {
        switch self {
        case .topHeadlines:
            return "top-headlines"
        }
    }
    
    private var schema: HTTPSchema {
        switch self {
        default :
            return .HTTPS
        }
    }
    
    private var host: String {
        switch self {
        default :
            return "newsapi.org"
        }
    }
    
    private var path: String {
        switch self {
        default :
            return "v2"
        }
    }
    
    private var base: String {
        switch self {
        default:
            return "\(schema.rawValue)://\(host)"
        }
    }
    
    var fullURL: String {
        switch self {
        default :
            return "\(self.base)/\(self.path)/\(self.name)"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .topHeadlines:
            return [:]
        }
    }
    
    var headers: [String: String] {
        return [ NewsAPIConstants.HeaderParameterKeys.APIKey : NewsAPIConstants.HeaderParameterValues.APIKey]
    }
    
    var method: HTTPMethod {
        switch self {
        case .topHeadlines:
            return .get
        }
    }
}
