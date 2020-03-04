//
//  BaseAPIService.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/4/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

protocol BaseAPIServiceProtocol {
    func execute<Model:Codable>(endPoint: Endpointable, parameters:[String:Any], completionHandler: @escaping (Swift.Result<Model, Error>) -> Void )
    
}

extension BaseAPIServiceProtocol {
    
    func execute<Model:Codable>(endPoint: Endpointable, parameters:[String:Any] = [:], completionHandler: @escaping (Swift.Result<Model, Error>) -> Void ) {
        
        var generalParameters = [String:Any]()
        generalParameters.merge(with: parameters)
        
        
        Alamofire.request(endPoint.fullURL, method: Alamofire.HTTPMethod.init(rawValue: endPoint.method.rawValue)!, parameters: generalParameters, headers: nil).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    print(String(bytes: data, encoding: .utf8))
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    completionHandler(Swift.Result.success(object))
                }
                catch {
                    completionHandler(Swift.Result.failure(BaseServiceError.parsingError))
                }
            case .failure(let error):
                completionHandler(Swift.Result.failure(BaseServiceError.serverError(message: error.localizedDescription, code: error.code)))
            }
        }
    }
}
