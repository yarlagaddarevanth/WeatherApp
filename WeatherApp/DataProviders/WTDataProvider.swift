//
//  WTDataProvider.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import Foundation

protocol WTWeatherDataProvider {}

protocol WTCityWeatherDataProvider: WTWeatherDataProvider {
    func weatherData(for city: String, onSuccess: @escaping ((WTCityWeatherData) -> Void), onFailure: @escaping ((Error) -> Void))
}
