//
//  SettingsCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator


class SettingsCoordinator: NavigationCoordinator<SettingsRoute> {
    
    init() {
        super.init(initialRoute: .settings)
        self.rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    override func prepareTransition(for route: SettingsRoute) -> NavigationTransition {
        switch route {
        case .settings:
            let viewModel = SettingsViewModel(router: self.unownedRouter)
            let viewController: SettingsViewController  = Storyboards.main.instantiate()!
            viewController.bind(to: viewModel)
            return .push(viewController)
            
        case .countrySelection:
            let viewModel = CountriesViewModel(settingsRouter: self.unownedRouter, countreyService: CountryService.shared)
            let controller: CountriesViewController = Storyboards.main.instantiate()!
            controller.bind(to: viewModel)
            return .presentFullScreen(controller)
            
        case .categorySelection:
            let tagsViewModel = TagsViewModel(startupRouter: nil , settingsRouter: self.unownedRouter)
            let tagsController: TagsViewController = Storyboards.main.instantiate()!
            tagsController.bind(to: tagsViewModel)
            return .presentFullScreen(tagsController)
            
        case .exit:
            return .dismiss()
        }
    }
}
