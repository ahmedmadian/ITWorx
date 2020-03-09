//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK:- Singleton
    static let shared: CoreDataManager = CoreDataManager()
    
    // MARK:- Properties
    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let persistentContainerLoadError = error {
                fatalError("Unresolved error \(persistentContainerLoadError), \(persistentContainerLoadError.userInfo)")
            }
        })
        return container
    }()
    
    // MARK:- Methods
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

extension NSManagedObject {
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    class func create<Type>(_ context: NSManagedObjectContext) -> Type {
        let entity = NSEntityDescription.entity(forEntityName: className, in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        return object as! Type
    }
}
