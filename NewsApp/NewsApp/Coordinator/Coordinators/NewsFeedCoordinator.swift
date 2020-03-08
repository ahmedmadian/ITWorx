//
//  NewsFeedCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator
import SafariServices

class NewsFeedCoordinator: NavigationCoordinator<NewsFeedRoute> {
    
    init() {
        super.init(initialRoute: .feedList)
    }
    
    override func prepareTransition(for route: NewsFeedRoute) -> NavigationTransition {
        switch route {
        case .feedList:
            let articlesRepo = ArticlesDataRepository(remoteDataSource: ArticlesRemoteService.shared)
            let favoritsRepo = FavouritesRepository(localDataSource: FavouritesLocalService(context: CoreDataManager.shared.managedContext))
            let viewModel = ArticlesViewModel(router: self.unownedRouter, articlesRepository: articlesRepo, favoritesRepository: favoritsRepo)
            let viewController: ArticlesViewController = Storyboards.main.instantiate()!
            viewController.bind(to: viewModel)
            
            return .push(viewController)
            
        case .safari(let url):
            let svc = SFSafariViewController(url: url)
            return .present(svc)
        }
    }
}
