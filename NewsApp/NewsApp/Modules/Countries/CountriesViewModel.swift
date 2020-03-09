//
//  CountriesViewModel.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator
import RxCocoa

class CountriesViewModel: CountriesViewModelType, CountriesViewModelInput, CountriesViewModelOutput {
    
    
    
    var viewLoaded: PublishSubject<Void>
    var selectedCountry: PublishSubject<CountryViewModel>
    var deselectedCountry: PublishSubject<CountryViewModel>
    var didTapNext: PublishSubject<Void>
    var errorMessage: PublishSubject<String>
    
    var data: Observable<[CountryViewModel]>

    private var itemSelected = false
    
    // MARK: - Dependancies
    //private let startupRouter: UnownedRouter<AppStartupRoute>?
    private let countreyService: CountryServiceProtocol
    private let settingsRouter: UnownedRouter<SettingsRoute>?
    
    init(settingsRouter: UnownedRouter<SettingsRoute>?, countreyService: CountryServiceProtocol){
//        self.startupRouter = startupRouter
        self.countreyService = countreyService
        self.settingsRouter = settingsRouter
        
        /// Init Inputs
        self.viewLoaded = PublishSubject<Void>().asObserver()
        self.selectedCountry = PublishSubject<CountryViewModel>().asObserver()
        self.deselectedCountry = PublishSubject<CountryViewModel>().asObserver()
        self.didTapNext = PublishSubject<Void>().asObserver()
        
        let loadedData = BehaviorRelay<[CountryViewModel]>(value: [])
        data = loadedData.asObservable()
        
        errorMessage = PublishSubject<String>()
        
        self.data = viewLoaded.flatMapLatest( { _ -> Observable<[CountryViewModel]> in
            return self.countreyService.fetchCountries()!.map { $0.map {CountryViewModel(with: $0) }}
        })
        
        _ = selectedCountry.subscribe(onNext: {
            self.itemSelected = true
            $0.isNotSelected.accept(false)
            Settings.shared.countryName = $0.title
            Settings.shared.countryiso2 = $0.isoCode
        })
        
        _ = deselectedCountry.subscribe(onNext: {
            self.itemSelected = false
            $0.isNotSelected.accept(true)
        })
        
        
        _ = didTapNext.subscribe(onNext: {
            if self.itemSelected {
                if let sRouter = self.settingsRouter {
                    sRouter.trigger(.exit)
                }
            } else {
                self.errorMessage.onNext("PLEASE SELECT COUNTRY")
            }
        })
    }
}
