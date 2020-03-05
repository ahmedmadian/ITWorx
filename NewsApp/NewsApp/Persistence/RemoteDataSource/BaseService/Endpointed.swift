//
//  Endpointed.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol Endpointable {
    var name: String { get }
    var parameters: [String : Any] { get }
    var headers: [String : String] { get }
    var fullURL: String { get }
    var method: HTTPMethod { get }
}

