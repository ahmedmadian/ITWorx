//
//  SettingsService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

class Settings {
    
    static var shared = Settings()
    private let defualts = UserDefaults.standard
    
    
    var launchedBefore: Bool {
        get{
            return defualts.bool(forKey: LAUNCHED_BEFORE)
        }
        set{
            defualts.set(newValue, forKey: LAUNCHED_BEFORE)
        }
    }
    
    var countryName: String? {
        get {
            return defualts.string(forKey: COUNTRY_NAME)
        }
        set {
            defualts.set(newValue, forKey: COUNTRY_NAME)
        }
    }
    
    var countryiso2: String? {
        get {
            return defualts.string(forKey: COUNTRY_ISO)
        }
        set {
            defualts.set(newValue, forKey: COUNTRY_ISO)
        }
    }
    
    var categories: [String]?  {
        get{
            return defualts.array(forKey: CATEGORIES) as? [String]
        }
        set {
            defualts.set(newValue, forKey: CATEGORIES)
        }
    }
    
    
    
    // MARK:- Settings Service Keys
    private let LAUNCHED_BEFORE = "LanchedBefore"
    private let COUNTRY_NAME = "CountryName"
    private let COUNTRY_ISO = "CountryISO2"
    private let CATEGORIES = "Categories"
    
}

