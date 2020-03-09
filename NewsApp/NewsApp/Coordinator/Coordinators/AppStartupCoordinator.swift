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
        let initialRoute: AppStartupRoute = Settings.shared.launchedBefore ? .home : .onboarding
        super.init(initialRoute: initialRoute)
        self.rootViewController.navigationBar.isHidden = true
    }
    
    override func prepareTransition(for route: AppStartupRoute) -> NavigationTransition {
        switch route {
        case .home:
            return .presentFullScreen(HomeTabCoordinator(), animation: .fade)
        case .onboarding:
            return .presentFullScreen(OnBordingCoordinator(appStartupRoute: self))
        }
        
    }
}
