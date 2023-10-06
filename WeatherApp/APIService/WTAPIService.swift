//
//  WTAPIService.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import Foundation

let kAppID = "4c474428e6871538640cbea4ec4c66ff"

//MARK: - APIService
protocol WTAPIService {}

protocol WTCityAPIService {
    var urlBuilder: WTCityAPIURLBuilder { get }
    
    func weather(for city: String,
                 onSuccess: @escaping (WTAPIResponse) -> Void,
                 onFailure: @escaping (Error) -> Void)
}

//MARK: - URLBuilder
protocol WTAPIURLBuilder {
    var baseURL: String {get}
}
extension WTAPIURLBuilder {
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/weather"
    }
}
protocol WTCityAPIURLBuilder: WTAPIURLBuilder {
    var cityUrlString: String {get}
}
