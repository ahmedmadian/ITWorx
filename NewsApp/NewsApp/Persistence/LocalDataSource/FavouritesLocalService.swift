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

protocol FavouritesLocalServiceProtocol {
    func add(imageURL: String, title: String, url: String, date: Date)
    func remove(url: String)
    func fetchFavourotes() -> Observable<[Favourite]>
}

class FavouritesLocalService: FavouritesLocalServiceProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
    }
    
    func add(imageURL: String, title: String, url: String, date: Date) {
        Favourite.createOrUpdate(imageURL: imageURL, title: title, url: url, date: date, context: managedObjectContext)
    }
    
    func remove(url: String) {
        Favourite.delete(url: url, context: managedObjectContext)
        
    }
    
    func fetchFavourotes() -> Observable<[Favourite]> {
        let favourites = Favourite.getAllSortedByDate(context: managedObjectContext)
        return Observable.of(favourites)
    }
    
}
