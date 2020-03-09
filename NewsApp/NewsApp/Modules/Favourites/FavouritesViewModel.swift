//
//  FavouritesViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator
import RxCocoa

class FavouritesViewModel: FavouritesViewModelType, FavouritesViewModelInput, FavouritesViewModelOutput {
    
    //MARK: - INPUT
    var viewAppeared: PublishSubject<Void>
    
    //MARK: - OUTPUT
    var data: Observable<[FavouriteViewModel]>
    
    // MARK: - DEPENDENCIES
       private var router: UnownedRouter<FavouritesRoute>
       private let favouritesRepository: FavouritesRepository
       
    init(router: UnownedRouter<FavouritesRoute>, favouritesRepository: FavouritesRepository) {
        
        /// init DEPENDENCIES
        self.router = router
        self.favouritesRepository = favouritesRepository
        
        /// init INPUT
        self.viewAppeared = PublishSubject<Void>().asObserver()
        
        /// init OUTPUT
        self.data = Observable.empty()
        self.data = viewAppeared.flatMapLatest( { _ -> Observable<[FavouriteViewModel]> in
            return self.favouritesRepository.fetchFavourites().map{ $0.map { FavouriteViewModel(with: $0) }}
        })
    }
    
}
