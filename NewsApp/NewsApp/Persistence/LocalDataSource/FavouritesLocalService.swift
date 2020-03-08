//
//  FavouritesLocalService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import RxCoreData

protocol FavouritesLocalServiceProtocol {
    func addTo(Favourites favourite: Favourite)
    func remove(favorite: Favourite)
    func fetchFavourotes() -> Observable<[Favourite]>
}

class FavouritesLocalService: FavouritesLocalServiceProtocol {
    
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func addTo(Favourites favourite: Favourite) {
        try? self.managedObjectContext.rx.update(favourite)
    }
    
    func remove(favorite: Favourite) {
        do {
            try self.managedObjectContext.rx.delete(favorite)
            try self.managedObjectContext.save()
        } catch let error {
            print(error)
        }
        
    }
    
    func fetchFavourotes() -> Observable<[Favourite]> {
        let favourites = managedObjectContext.rx.entities(Favourite.self, predicate: nil, sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]).map {
            $0.map{ ($0)} }
        
        return favourites
    }
    
}
