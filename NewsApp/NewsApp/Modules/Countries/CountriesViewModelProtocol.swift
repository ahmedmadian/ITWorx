//
//  CountriesViewModelProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CountriesViewModelInput {
    var viewLoaded: PublishSubject<Void> { get }
    var selectedCountry: PublishSubject<CountryViewModel> { get }
    var deselectedCountry: PublishSubject<CountryViewModel> { get }
    var didTapNext: PublishSubject<Void> { get }
}

protocol CountriesViewModelOutput {
    var data: Observable<[CountryViewModel]> {get}
    var errorMessage: PublishSubject<String> {get}
}

protocol CountriesViewModelType {
    var input: CountriesViewModelInput { get }
    var output: CountriesViewModelOutput { get }
}

extension CountriesViewModelType where Self: CountriesViewModelInput & CountriesViewModelOutput {
    var input: CountriesViewModelInput { return self }
    var output: CountriesViewModelOutput { return self }
}
