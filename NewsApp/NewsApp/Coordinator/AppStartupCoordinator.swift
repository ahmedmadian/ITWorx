//
//  AppStartupCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator
import SafariServices

class AppStartupCoordinator: NavigationCoordinator<AppStartupRoute> {
    
    init() {
        super.init(initialRoute: .home)
    }
    
    ///manage modules transition
    override func prepareTransition(for route: AppStartupRoute) -> NavigationTransition {
        switch route {
        case .home:
            let articlesRepo = ArticlesDataRepository(remoteDataSource: ArticlesRemoteService.shared)
            let viewModel = ArticlesViewModel(router: self.unownedRouter, articlesRepository: articlesRepo)
            let viewController: ArticlesViewController = Storyboards.main.instantiate()!
            viewController.bind(to: viewModel)
            
            return .push(viewController)
            
        case .safari(let url):
            let svc = SFSafariViewController(url: url)
            return .present(svc)
            
        default:
            return .push(UIViewController())
        }
    }
 
}
