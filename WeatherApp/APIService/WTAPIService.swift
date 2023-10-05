//
//  WTAPIService.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import Foundation

protocol WTAPIService {}

protocol WTCityAPIService {
    func weather(for city: String, onSuccess: (WTAPIResponse) -> Void, onFailure: (Error) -> Void)
}

class WTCityAPIServiceImpl: WTCityAPIService {
    func weather(for city: String, onSuccess: (WTAPIResponse) -> Void, onFailure: (Error) -> Void) {
        
    }
}
