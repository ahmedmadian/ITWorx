//
//  OnBordingCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/9/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

class OnBordingCoordinator: PageCoordinator<AppStartupRoute> {
    
    init(appStartupRoute: AppStartupCoordinator) {
        
        let countriesViewModel = CountriesViewModel(settingsRouter: nil, countreyService: CountryService.shared)
        let countriesController: CountriesViewController = Storyboards.main.instantiate()!
        countriesController.bind(to: countriesViewModel)
        
        let tagsViewModel = TagsViewModel(startupRouter: appStartupRoute.unownedRouter, settingsRouter: nil)
        let tagsController: TagsViewController = Storyboards.main.instantiate()!
        tagsController.bind(to: tagsViewModel)
        
        let on: ON = Storyboards.main.instantiate()!
        
        //super.init(pages: [countriesController, tagsController])
        super.init(rootViewController: on, pages: [countriesController, tagsController], loop: false, set: nil, direction: UIPageViewController.NavigationDirection.forward)
    }
}
