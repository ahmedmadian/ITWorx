//
//  AppStartupCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

class AppStartupCoordinator: NavigationCoordinator<AppStartupRoute> {
    
    init() {
        super.init(initialRoute: .home)
    }
    
 
}
