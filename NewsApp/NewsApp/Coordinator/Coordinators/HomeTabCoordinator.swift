//
//  HomeTabCoordinator.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import XCoordinator

class HomeTabCoordinator: TabBarCoordinator<HomeRoute> {
    
    // MARK:- Constants
    struct Constants {
        static let insetsBottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? -8 :  0
        static let insetsTop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 8 :  0
    }
    
    // MARK: Stored properties
    private let newsFeedRouter: StrongRouter<NewsFeedRoute>
    private let favouritesRouter: StrongRouter<FavouritesRoute>
    private let settingsRoute: StrongRouter<SettingsRoute>

    // MARK: Initialization
    convenience init() {
        
        let newsFeedCoordinator = NewsFeedCoordinator()
        newsFeedCoordinator.rootViewController.tabBarItem = HomeTabCoordinator.getTabBarItem(image: UIImage(named: "news"), tag: 0)
        
        let favouritesCoordinator = FavouritesCoordinator()
        favouritesCoordinator.rootViewController.tabBarItem = HomeTabCoordinator.getTabBarItem(image: UIImage(named: "star"), tag: 0)
        
        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.rootViewController.tabBarItem = HomeTabCoordinator.getTabBarItem(image: UIImage(named: "settings"), tag: 0)

        self.init(newsFeedRouter: newsFeedCoordinator.strongRouter, favourotiesRouter: favouritesCoordinator.strongRouter, settingsRoute: settingsCoordinator.strongRouter )
    }

    init(newsFeedRouter: StrongRouter<NewsFeedRoute>, favourotiesRouter: StrongRouter<FavouritesRoute>, settingsRoute: StrongRouter<SettingsRoute>) {
        self.favouritesRouter = favourotiesRouter
        self.newsFeedRouter = newsFeedRouter
        self.settingsRoute = settingsRoute
        
        super.init(tabs: [newsFeedRouter, favourotiesRouter, settingsRoute], select: newsFeedRouter)
    }
    
    static func getTabBarItem(image: UIImage?, tag: Int) -> UITabBarItem {
        let item = UITabBarItem.init(title: nil, image: image, selectedImage: image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        item.imageInsets = UIEdgeInsets(top: Constants.insetsTop, left: 0, bottom: Constants.insetsBottom, right: 0)
        return item
    }
}
