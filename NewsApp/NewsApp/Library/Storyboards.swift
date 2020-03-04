//
//  Storyboards.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

enum Storyboards: String {
    
    case main = "Main"
    
    public func instantiate<ViewController: UIViewController>() -> ViewController? {
        guard let viewController = UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController else {
            return nil
        }
        return viewController
    }
    
}
