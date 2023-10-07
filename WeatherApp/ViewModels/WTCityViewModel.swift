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
    private let icon: String?
    var iconUrlString: String?

    init(weatherData: WTCityWeatherData) {
        heading = weatherData.cityName
        subHeading = weatherData.weather?.main
        description = weatherData.weather?.description.firstUppercased
        icon = weatherData.weather?.icon
        if let icon = icon {
            iconUrlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        }
    }
}
