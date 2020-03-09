//
//  CountryService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/8/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation
import RxSwift

protocol CountryServiceProtocol {
    func fetchCountries() -> Observable<[Country]>?
}

final class CountryService:  CountryServiceProtocol{
    
    //MARK:- Properties
    static let shared = CountryService()
    
    private let fileName = "countryISO2"
    private let fileType = "json"
    
    // MARK:- Initializers
    private init() {}
    
    func fetchCountries() -> Observable<[Country]>? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {return nil}
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe) else {return nil}
        guard let items = try? JSONDecoder().decode(CountryWrapper.self, from: data) else {return nil}
        
        let countries = items.data?.map { Country(name: $0.value, iso2: $0.key)}.sorted { $0.name < $1.name }
        
        return Observable.of(countries!)
    }
    
}

class CountryWrapper: Codable {
    var data: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
