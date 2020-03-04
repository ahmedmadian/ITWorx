//
//  AppConstants.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

struct AppConstants {
    #if DEBUG
    static let defaultBaseUrl = "http://blinkappservices.com"
    #else
    static let defaultBaseUrl = "http://blinkappservices.com"
    #endif
}
