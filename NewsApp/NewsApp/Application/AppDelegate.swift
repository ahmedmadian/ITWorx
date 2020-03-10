//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let router = AppStartupCoordinator().strongRouter
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        customApperanceForPageControl()
        window = UIWindow(frame: UIScreen.main.bounds)
        router.setRoot(for: window!)
        
        return true
    }
    
    private func customApperanceForPageControl(){
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}

