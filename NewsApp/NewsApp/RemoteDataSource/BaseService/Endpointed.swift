//
//  Endpointed.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol Endpointable {
    var path: String { get }
    var base: String { get }
    var method: HTTPMethod { get }
    var name: String { get }
    var parameters: [String : Any] {get}
}

extension Endpointable {
    var base: String {
        return AppConstants.defaultBaseUrl
    }
}
