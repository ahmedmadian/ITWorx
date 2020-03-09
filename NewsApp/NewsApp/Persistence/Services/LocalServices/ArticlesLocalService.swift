//
//  ArticlesLocalService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData

protocol ArticlesLocalServiceProtocol {
    func add(articles: [Article])
    
}

class ArticlesLocalService: ArticlesLocalServiceProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func add(articles: [Article]) {
    }
}
