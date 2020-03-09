//
//  FavouritesViewModelProtocols.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavouritesViewModelInput {
    var viewAppeared: PublishSubject<Void> { get }
}

protocol FavouritesViewModelOutput {
    var data: Observable<[FavouriteViewModel]> {get}
}

protocol FavouritesViewModelType {
    var input: FavouritesViewModelInput { get }
    var output: FavouritesViewModelOutput { get }
}

extension FavouritesViewModelType where Self: FavouritesViewModelInput & FavouritesViewModelOutput {
    var input: FavouritesViewModelInput { return self }
    var output: FavouritesViewModelOutput { return self }
}
