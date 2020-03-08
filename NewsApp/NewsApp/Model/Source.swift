//
//  Source.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct Source: Codable {
    let name: String
}

extension Source: Persistable {
    static var entityName: String {
        return "Source"
    }
    
    static var primaryAttributeName: String {
        return "name"
    }
    
    var identity: String {
        return "name"
    }
    
    init(entity: NSManagedObject) {
        name = entity.value(forKey: "name") as! String
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(name, forKey: "name")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
    typealias T = NSManagedObject
    
    
}
