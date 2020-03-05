//
//  SettingsService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class SettingsService {
    
    static var shared = SettingsService()
    private let defualts = UserDefaults.standard
    
    
    var launchedBefore: Bool {
        get{
            return defualts.bool(forKey: LAUNCHED_BEFORE)
        }
        set{
            defualts.set(newValue, forKey: LAUNCHED_BEFORE)
        }
    }
    
    var country: String? {
        get {
            return defualts.string(forKey: COUNTRY_ISO)
        }
        set {
            defualts.set(newValue, forKey: COUNTRY_ISO)
        }
    }
    
    // MARK: Settings Service Keys
    private let LAUNCHED_BEFORE = "LanchedBefore"
    private let COUNTRY_ISO = "CountrISO"
    
}
