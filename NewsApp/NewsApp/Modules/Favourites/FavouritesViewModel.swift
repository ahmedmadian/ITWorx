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
    var selectFavourite: PublishSubject<FavouriteViewModel>
    
    //MARK: - OUTPUT
    var data: Observable<[FavouriteViewModel]>
    var title: Observable<String>
    
    // MARK: - DEPENDENCIES
       private var router: UnownedRouter<FavouritesRoute>
       private let favouritesRepository: FavouritesRepository
       
    init(router: UnownedRouter<FavouritesRoute>, favouritesRepository: FavouritesRepository) {
        
        /// init DEPENDENCIES
        self.router = router
        self.favouritesRepository = favouritesRepository
        
        /// init INPUT
        self.viewAppeared = PublishSubject<Void>().asObserver()
        self.selectFavourite = PublishSubject<FavouriteViewModel>().asObserver()
        
        /// init OUTPUT
        self.data = Observable.empty()
        self.title = Observable.of("Saved")
        self.data = viewAppeared.flatMapLatest( { _ -> Observable<[FavouriteViewModel]> in
            return self.favouritesRepository.fetchFavourites().map{ $0.map { FavouriteViewModel(with: $0) }}
        })
        
        _ = selectFavourite.subscribe(onNext:{
            guard let url = URL(string: $0.url) else { return }
            self.router.trigger(.safari(url: url))
        })
    }
    
}
