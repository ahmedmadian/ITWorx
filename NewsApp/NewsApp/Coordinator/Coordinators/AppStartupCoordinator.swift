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
        var initialRoute: AppStartupRoute = .onboarding
        
//        if SettingsService.shared.launchedBefore {
//            initialRoute = .home
//        } else {
//            SettingsService.shared.launchedBefore = true
//            initialRoute = .onboarding
//        }
        
        super.init(initialRoute: initialRoute)
        self.rootViewController.navigationBar.isHidden = true
        
    }
    
    override func prepareTransition(for route: AppStartupRoute) -> NavigationTransition {
        switch route {
        case .home:
            return .push(HomeTabCoordinator())
        case .onboarding:
            let viewModel = CountriesViewModel(router: self.unownedRouter, countreyService: CountryService.shared)
            let controller: CountriesViewController = Storyboards.main.instantiate()!
            controller.bind(to: viewModel)
            return .push(controller)
        }
    }
}
