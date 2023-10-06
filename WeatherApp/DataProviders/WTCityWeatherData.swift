//
//  WTCityWeatherData.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

struct WTCityWeatherData {
    let cityName: String
    var weather: WTCityWeather? = nil
}

struct WTCityWeather {
    let id: Double
    let main: String
    let description: String
    let icon: String
}
