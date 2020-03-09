//
//  SettingsViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator
import RxCocoa

class SettingsViewModel: SettingsViewModelType, SettingsViewModelInput, SettingsViewModelOutput {
    
    // MARK: - INPUTS
    var viewLoaded: PublishSubject<Void>
    var didTapEditCountry: PublishSubject<Void>
    var didTapEditCategory: PublishSubject<Void>
    
    // MARK: - OUTPUTS
    var title: Observable<String>
    var selectedCountry: Observable<String>
    var prefrences: Observable<String>
    
    // MARK: - DEPENDENCIES
    private let router: UnownedRouter<SettingsRoute>
    
    init(router: UnownedRouter<SettingsRoute>) {
        
        /// init DEPENDENCIES
        self.router = router
        
        /// init INPUTS
        self.viewLoaded = PublishSubject<Void>().asObserver()
        didTapEditCountry = PublishSubject<Void>().asObserver()
        didTapEditCategory = PublishSubject<Void>().asObserver()

        /// init OUTPUTS
        self.title = Observable.just("Settings")
        
        self.selectedCountry = viewLoaded.flatMapLatest({_ -> Observable<String> in
            return Observable.just(Settings.shared.countryName!)
        })
        
        self.prefrences = viewLoaded.flatMapLatest({_ -> Observable<String> in
            return Observable.just(Settings.shared.categories!.joined(separator: ", "))
        })
       
        _ = didTapEditCountry.subscribe(onNext: {
            self.router.trigger(.countrySelection)
        })
        
        _ = didTapEditCategory.subscribe(onNext: {
            self.router.trigger(.categorySelection)
        })
    }
}
