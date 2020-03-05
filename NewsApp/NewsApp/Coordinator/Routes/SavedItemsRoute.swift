//
//  SavedItemsRoute.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

enum SavedItemsRoute: Route {
    case savedItemList
    case safari(url: URL)
}
