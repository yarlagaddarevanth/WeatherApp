//
//  WTMockData.swift
//  WeatherAppTests
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation
@testable import WeatherApp

struct WTMockData {
    static let mockNewYorkSunnyWeatherData = WTCityWeatherData(cityName: "New York",
                                                               weather: WTCityWeather(id: 20,
                                                                                      main: "Sunny",
                                                                                      description: "sun is coming out",
                                                                                      icon: "02n"))
}
