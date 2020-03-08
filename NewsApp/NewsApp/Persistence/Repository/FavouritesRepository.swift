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
    func addToFavourites(favourite: Favourite)
    func remove(favorite: Favourite)
}

class FavouritesRepository: FavouritesRepositoryProtocol{
   
    //MARK:- Properties
    private let localDataSource: FavouritesLocalServiceProtocol
    
    // MARK:- Initializers
    init(localDataSource: FavouritesLocalServiceProtocol) {
        self.localDataSource = localDataSource
    }
    
    //MARK:- Methods
    func addToFavourites(favourite: Favourite) {
        self.localDataSource.addTo(Favourites: favourite)
    }
    
    func fetchFavourites() -> Observable<[Favourite]> {
        return self.localDataSource.fetchFavourotes()
    }
    
    func remove(favorite: Favourite) {
        self.localDataSource.remove(favorite: favorite)
    }
    
       
    
}
