//
//  WTCityViewModel.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation
import UIKit

struct WTCityViewModel {
    let heading: String?
    let subHeading: String?
    let description: String?
    private let icon: String?
    var iconUrlString: String?
    let placeholderImage = UIImage(named: "all-weather")
    var temperatureText: String?
    var additionalInfo: String?

    init(weatherData: WTCityWeatherData) {
        heading = weatherData.cityName
        subHeading = weatherData.weather?.main
        description = weatherData.weather?.description?.firstUppercased
        icon = weatherData.weather?.icon
        if let icon = icon {
            iconUrlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        }
        if let temp = weatherData.weather?.temp {
            temperatureText = "\(temp) °F"
        }
        if let humidity = weatherData.weather?.humidity {
            additionalInfo = "Humidity: \(humidity)%"
        }
    }
}
