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
    var didTapNext: PublishSubject<Void>
    var errorMessage: PublishSubject<String>
    
    var data: Observable<[CountryViewModel]>

    private var itemSelected = false
    
    // MARK: - Dependancies
    private let router: UnownedRouter<AppStartupRoute>
    private let countreyService: CountryServiceProtocol
    
    init(router: UnownedRouter<AppStartupRoute>, countreyService: CountryServiceProtocol){
        self.router = router
        self.countreyService = countreyService
        
        /// Init Inputs
        self.viewLoaded = PublishSubject<Void>().asObserver()
        self.selectedCountry = PublishSubject<CountryViewModel>().asObserver()
        self.didTapNext = PublishSubject<Void>().asObserver()
        
        let loadedData = BehaviorRelay<[CountryViewModel]>(value: [])
        data = loadedData.asObservable()
        
        errorMessage = PublishSubject<String>()
        
        self.data = viewLoaded.flatMapLatest( { _ -> Observable<[CountryViewModel]> in
            return self.countreyService.fetchCountries()!.map { $0.map {CountryViewModel(with: $0) }}
        })
        
        _ = selectedCountry.subscribe(onNext: {
            self.itemSelected = true
            SettingsService.shared.countryName = $0.name
            SettingsService.shared.countryiso2 = $0.isoCode
        })
        
        _ = didTapNext.subscribe(onNext: {
            if self.itemSelected {
                self.router.trigger(.home)
            } else {
                self.errorMessage.onNext("PLEASE SELECT COUNTRY")
            }
        })
    }
}
