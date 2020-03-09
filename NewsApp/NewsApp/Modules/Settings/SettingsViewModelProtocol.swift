//
//  SettingsViewModelProtocol.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SettingsViewModelInput {
     var viewLoaded: PublishSubject<Void> { get }
    var didTapEditCountry: PublishSubject<Void> { get }
}

protocol SettingsViewModelOutput {
    var title: Observable<String> { get }
    var selectedCountry: Observable<String> { get }
}

protocol SettingsViewModelType {
    var input: SettingsViewModelInput { get }
    var output: SettingsViewModelOutput { get }
}

extension SettingsViewModelType where Self: SettingsViewModelInput & SettingsViewModelOutput {
    var input: SettingsViewModelInput { return self }
    var output: SettingsViewModelOutput { return self }
}
