//
//  WTCityWeatherDataProviderImpl.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

class WTCityWeatherDataProviderImpl: WTCityWeatherDataProvider {
    
    func weatherData(for city: String, onSuccess: @escaping ((WTCityWeatherData) -> Void), onFailure: @escaping ((Error) -> Void)) {
        WTCityAPIServiceImpl(urlBuilder: WTCityAPIURLBuilderImpl()).weather(for: "london") { [weak self] response in
            guard let self = self else { return }
            
            if let data = self.transform(apiResponse: response) {
                onSuccess(data)
            } else {
                onFailure(WTError())
            }
        } onFailure: { error in
            onFailure(error)
        }

    }
}

extension WTCityWeatherDataProviderImpl {
    fileprivate func transform(apiResponse: WTAPIResponse) -> WTCityWeatherData? {
        WTCityWeatherData.data(from: apiResponse)
    }
}

extension WTCityWeatherData {
    static func data(from apiResponse: WTAPIResponse) -> WTCityWeatherData? {
        guard let apiResponseWeather = apiResponse.weather.first else {
            return WTCityWeatherData(cityName: apiResponse.name)
        }
        
        return WTCityWeatherData(cityName: apiResponse.name,
                                 weather: WTCityWeather(id: apiResponseWeather.id,
                                                 main: apiResponseWeather.main,
                                                 description: apiResponseWeather.description,
                                                 icon: apiResponseWeather.icon))
    }
}

