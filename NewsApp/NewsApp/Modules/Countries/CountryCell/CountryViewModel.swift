//
//  CountryViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CountryViewModel: CountryViewModelType, CountryViewModelInput, CountryViewModelOutput {
    
    var title: String
    var isNotSelected: BehaviorRelay<Bool>
    var isoCode: String
    
    init(with country: Country) {
        self.title = country.name
        self.isoCode = country.iso2
        isNotSelected = BehaviorRelay<Bool>(value: true)
    }
}
