//
//  WTDataProvider.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import Foundation

protocol WTWeatherDataProvider {}

protocol WTCityWeatherDataProvider: WTWeatherDataProvider {
    func weather(for city: String) -> [String]
}


class WTCityWeatherDataProviderImpl: WTCityWeatherDataProvider {
    func weather(for city: String) -> [String] {
        return []
    }
}
