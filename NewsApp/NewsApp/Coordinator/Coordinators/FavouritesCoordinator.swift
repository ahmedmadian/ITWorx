//
//  FavouritesCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/7/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator
import SafariServices

class FavouritesCoordinator: NavigationCoordinator<FavouritesRoute> {
    
    init() {
        super.init(initialRoute: .favouritesList)
       }
    
    
    override func prepareTransition(for route: FavouritesRoute) -> NavigationTransition {
        switch route {
        case .favouritesList:
            let favouritesRepo = FavouritesRepository(localDataSource: FavouritesLocalService(context: CoreDataManager.shared.managedContext))
            let viewModel = FavouritesViewModel(router: self.unownedRouter, favouritesRepository: favouritesRepo)
            let controller: FavouritesViewController  = Storyboards.main.instantiate()!
            controller.bind(to: viewModel)
            return .push(controller)
            
        case .safari(let url):
            let svc = SFSafariViewController(url: url)
            return .present(svc)
        }
    }
    
}
