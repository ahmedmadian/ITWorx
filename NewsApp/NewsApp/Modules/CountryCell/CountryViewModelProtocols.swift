//
//  CountryViewModelProtocols.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CountryViewModelInput {
}

protocol CountryViewModelOutput {
    var title: BehaviorSubject<String> {get}
    var imageURL: BehaviorSubject<String> {get}
    var isBorderHidden: BehaviorRelay<Bool> { get }
}

protocol CountryViewModelType {
    var input: CountryViewModelInput { get }
    var output: CountryViewModelOutput { get }
}

extension CountryViewModelType where Self: CountryViewModelInput & CountryViewModelOutput {
    var input: CountryViewModelInput { return self }
    var output: CountryViewModelOutput { return self }
}
