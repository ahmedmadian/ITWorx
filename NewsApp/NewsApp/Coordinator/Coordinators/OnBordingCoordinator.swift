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
        
        
        let rootController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll , navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        rootController.view.backgroundColor = #colorLiteral(red: 0.9958658814, green: 1, blue: 0.9999271035, alpha: 1)
        
        super.init(rootViewController: rootController, pages: [countriesController, tagsController], loop: false, set: nil, direction: UIPageViewController.NavigationDirection.forward)
    }
}
