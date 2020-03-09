//
//  FavouriteViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class FavouriteViewModel {
    
    let imageURL: String
    let title: String
    let url: String
    
    init(with favourite: Favourite) {
        self.imageURL = favourite.imageURL ?? ""
        self.url = favourite.url ?? ""
        self.title = favourite.title ?? ""
    }
}
