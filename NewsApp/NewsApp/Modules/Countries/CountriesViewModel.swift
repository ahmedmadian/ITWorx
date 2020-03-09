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
    
    // MARK:- INPUTS
    var viewLoaded: PublishSubject<Void>
    var selectedCountry: PublishSubject<CountryViewModel>
    var deselectedCountry: PublishSubject<CountryViewModel>
    
    // MARK:- OUTPUTS
    var errorMessage: PublishSubject<String>
    var data: Observable<[CountryViewModel]>

    private var itemSelected = false
    
    // MARK: - DEPENDENCIES
    private let countreyService: CountryServiceProtocol
    private let settingsRouter: UnownedRouter<SettingsRoute>?
    
    init(settingsRouter: UnownedRouter<SettingsRoute>?, countreyService: CountryServiceProtocol){
        
        /// init DEPENDENCIES
        self.countreyService = countreyService
        self.settingsRouter = settingsRouter
        
        /// init INPUTS
        self.viewLoaded = PublishSubject<Void>().asObserver()
        self.selectedCountry = PublishSubject<CountryViewModel>().asObserver()
        self.deselectedCountry = PublishSubject<CountryViewModel>().asObserver()
        
        /// init OUTPUTS
        data = Observable.empty()
        errorMessage = PublishSubject<String>()
        
        self.data = viewLoaded.flatMapLatest( { _ -> Observable<[CountryViewModel]> in
            return self.countreyService.fetchCountries()!.map { $0.map { country -> CountryViewModel in
                let viewModel = CountryViewModel(with: country)
                viewModel.isSelected.accept(Settings.shared.countryName ?? "" == viewModel.title)
                return viewModel}}
        })
        
        _ = selectedCountry.subscribe(onNext: {
            self.itemSelected = true
            $0.isSelected.accept(!$0.isSelected.value)
            Settings.shared.countryName = $0.title
            Settings.shared.countryiso2 = $0.isoCode
            if self.itemSelected {
                if let sRouter = self.settingsRouter {
                    sRouter.trigger(.exit)
                }
            } else {
                self.errorMessage.onNext("PLEASE SELECT COUNTRY")
            }
        })
        
        _ = deselectedCountry.subscribe(onNext: {
            self.itemSelected = false
            $0.isSelected.accept(!$0.isSelected.value)
        })
    }
}
