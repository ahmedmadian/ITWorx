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
        self.rootViewController.navigationBar.isHidden = true
    }
    
    override func prepareTransition(for route: AppStartupRoute) -> NavigationTransition {
        switch route {
        case .home:
        return .push(HomeTabCoordinator())
        default:
            return .push(UIViewController())
        }
    }
 
}
