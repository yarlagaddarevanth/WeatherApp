//
//  WTCityViewModel.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

struct WTCityViewModel {
    let heading: String?
    let subHeading: String?
    let description: String?
    
    init(weatherData: WTCityWeatherData) {
        heading = weatherData.cityName
        subHeading = weatherData.weather?.main
        description = weatherData.weather?.description.firstUppercased
    }
}
