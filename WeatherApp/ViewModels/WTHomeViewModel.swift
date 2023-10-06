//
//  WTHomeViewModel.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

class WTHomeViewModel {
    var cityViewModel: WTCityViewModel?
    let dataProvider: WTCityWeatherDataProvider
    
    var onUpdate: (() -> Void)?
    
    init(dataProvider: WTCityWeatherDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func initialLoad() {
        dataProvider.weatherData(for: "london") { [weak self] weatherData in
            self?.updateViewModel(with: weatherData)
        } onFailure: { [weak self] error in
            self?.handle(error: error)
        }
    }
    
    func updateViewModel(with weatherData: WTCityWeatherData) {
        cityViewModel = WTCityViewModel(weatherData: weatherData)
        onUpdate?()
    }
}

//MARK: - Error Handling
extension WTHomeViewModel {
    func handle(error: Error) {
        print("rev show error alert")
    }
}
