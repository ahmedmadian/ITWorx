//
//  CountryViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class CountryViewModel {
    let name: String
    let isoCode: String
    var isSelected: Bool
    
    init(with country: Country) {
        self.name = country.name
        self.isoCode = country.iso2
        self.isSelected = false
    }
}
