//
//  HTTPMethod+HTTPSchema.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

public enum HTTPSchema: String {
    case HTTP = "http"
    case HTTPS = "https"
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
