//
//  NewsFeedRoute.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

enum NewsFeedRoute: Route {
    case feedList
    case safari(url: URL)
}