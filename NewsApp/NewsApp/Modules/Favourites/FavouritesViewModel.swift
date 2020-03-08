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
    
    var viewAppeared: PublishSubject<Void>
    var data: Observable<[FavouriteViewModel]>
    
    // MARK: - Dependancies
       private var router: UnownedRouter<FavouritesRoute>
       private let favouritesRepository: FavouritesRepository
       
    init(router: UnownedRouter<FavouritesRoute>, favouritesRepository: FavouritesRepository) {
        self.router = router
        self.favouritesRepository = favouritesRepository
        
        /// Init Inputs
        self.viewAppeared = PublishSubject<Void>().asObserver()
        
        let loadedData = BehaviorRelay<[FavouriteViewModel]>(value: [])
        data = loadedData.asObservable()
        
        self.data = viewAppeared.flatMapLatest( { _ -> Observable<[FavouriteViewModel]> in
            return self.favouritesRepository.fetchFavourites().map{ $0.map { FavouriteViewModel(with: $0) }}
        })
    }
    
}
