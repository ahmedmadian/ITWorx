//
//  BaseServiceError.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum BaseServiceError: LocalizedError {
    case parsingError
    case serverError(message: String, code: Int)
    
    var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Failure"
        case .serverError(let message): return "\(message)<\(code)>"
        }
    }
}
