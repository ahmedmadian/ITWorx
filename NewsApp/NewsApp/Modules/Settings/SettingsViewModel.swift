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
    
    
   
    var viewLoaded: PublishSubject<Void>
    var didTapEditCountry: PublishSubject<Void>
    
    var title: Observable<String>
    var selectedCountry: Observable<String>

    
    // MARK: - Dependancies
    private let router: UnownedRouter<SettingsRoute>
    
    init(router: UnownedRouter<SettingsRoute>) {
        self.router = router
        
        self.viewLoaded = PublishSubject<Void>().asObserver()
        didTapEditCountry = PublishSubject<Void>().asObserver()

        self.title = Observable.just("Settings")
        
        self.selectedCountry = viewLoaded.flatMapLatest({_ -> Observable<String> in
            return Observable.just(Settings.shared.countryName!)
        })
       
        
        _ = didTapEditCountry.subscribe(onNext: {
            self.router.trigger(.countrySelection)
        })
    }
}
