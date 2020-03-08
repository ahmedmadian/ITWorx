//
//  Favourite.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct Favourite {
    let imageURL: String
    let url: String
    let title: String
    let date: Date
}

extension Favourite: Persistable {
    
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "Favourite"
    }
    
    static var primaryAttributeName: String {
        return "title"
    }
    
    var identity: String {
        return "title"
    }
    
    init(entity: NSManagedObject) {
        imageURL = entity.value(forKey: "imageURL") as! String
        url = entity.value(forKey: "url") as! String
        title = entity.value(forKey: "title") as! String
        date = entity.value(forKey: "date") as! Date
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(imageURL, forKey: "imageURL")
        entity.setValue(url, forKey: "url")
        entity.setValue(title, forKey: "title")
        entity.setValue(date, forKey: "date")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
    func remove(_ entity: NSManagedObject) {
        entity.managedObjectContext?.delete(entity)
    }
    
}
