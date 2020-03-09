//
//  Favourite.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import CoreData

extension Favourite {
    class func createOrUpdate(imageURL: String, title: String, url: String, date: Date, context: NSManagedObjectContext) {
        
        context.performAndWait {
            var item : Favourite
            
            if let existingItem = Favourite.getByURL(url: url, inContext: context) {
                item = existingItem
            } else {
                item = Favourite.create(context)
            }
            
            item.imageURL = imageURL
            item.title = title
            item.date = date
            item.url = url
            CoreDataManager.shared.saveContext()
        }
    }
    
    class func getByURL(url:String? , inContext context:NSManagedObjectContext) -> Favourite? {
        guard let url = url else{ return nil }
        
        var result: Favourite?
        
        context.performAndWait {
            let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
            var predicates: [NSPredicate] = []
            predicates.append(NSPredicate.init(format: "url = %@", url))
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            fetchRequest.returnsDistinctResults = true
            do {
                let items = try context.fetch(fetchRequest)
                result = items.first
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return result
    }
    
    class func getAllSortedByDate(context: NSManagedObjectContext) -> [Favourite] {
        let request: NSFetchRequest = Favourite.fetchRequest()
        request.sortDescriptors =  [NSSortDescriptor(key: "date", ascending: false)]
        do{
            return try context.fetch(request)
        } catch let error {
            print (error.localizedDescription)
        }
        return []
    }
    
    class func delete(url: String, context:NSManagedObjectContext) {
        guard let item = getByURL(url: url, inContext: context) else {return}
        context.delete(item)
        CoreDataManager.shared.saveContext()
    }
}
