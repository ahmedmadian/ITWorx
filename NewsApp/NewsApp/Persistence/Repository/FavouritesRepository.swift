//
//  FavouritesRepository.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol FavouritesRepositoryProtocol {
    func fetchFavourites() -> Observable<[Favourite]>
    func addToFavourites(imageURL: String, title: String, url: String, date: Date)
    func remove(url: String)
}

class FavouritesRepository: FavouritesRepositoryProtocol{
   
    //MARK:- Properties
    private let localDataSource: FavouritesLocalServiceProtocol
    
    // MARK:- Initializers
    init(localDataSource: FavouritesLocalServiceProtocol) {
        self.localDataSource = localDataSource
    }
    
    //MARK:- Methods
    func addToFavourites(imageURL: String, title: String, url: String, date: Date) {
        self.localDataSource.add(imageURL: imageURL, title: title, url: url, date: date)
    }
    
    func fetchFavourites() -> Observable<[Favourite]> {
        return self.localDataSource.fetchFavourotes()
    }
    
    func remove(url: String) {
        self.localDataSource.remove(url: url)
    }
    
       
    
}
