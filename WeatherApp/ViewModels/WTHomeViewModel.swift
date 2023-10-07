//
//  WTHomeViewModel.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation
import UIKit

class WTHomeViewModel: NSObject {
    var cityViewModel: WTCityViewModel?
    var searchBarViewModel: WTSearchBarViewModel?
    var locationManager: WTLocationManager?
    
    let dataProvider: WTCityWeatherDataProvider
    
    var onUpdate: (() -> Void)?
    
    init(dataProvider: WTCityWeatherDataProvider,
         searchBarViewModel: WTSearchBarViewModel = WTSearchBarViewModel()) {
        self.dataProvider = dataProvider
        self.searchBarViewModel = searchBarViewModel
        
        // Location manager
        self.locationManager = WTLocationManager()
    }
    
    func initialLoad() {
        // Priority 1: If we have user's permission for current location, fetch and show current location's weather
        // Priority 2: If we have user's latest search text, fetch and show current location's weather

        // Location manager handlers setup
        self.locationManager?.onReceivedCurrentCity = { [weak self] city in
            self?.fetchData(for: city)
        }
        self.locationManager?.onFailureToReceiveCity = { [weak self]  in
            if let latestSearchTextAvailable = WTSearchCacheManager.shared.retrieveLatest() {
                self?.fetchData(for: latestSearchTextAvailable)
            }
        }
        
        // Check and request location. The callbacks will handle error scenarios too, to fall back on fetching weather data for latest search text.
        if self.locationManager?.authorizationGranted == true {
            self.locationManager?.requestLocation()
        } else {
            self.locationManager?.requestAuthorizationAndLocation()
        }
    }
    
    func fetchData(for city: String) {
        dataProvider.weatherData(for: city) { [weak self] weatherData in
            self?.updateViewModel(with: weatherData)
            // Also save latest successful searched city
            WTSearchCacheManager.shared.saveLatest(text: weatherData.cityName)
        } onFailure: { [weak self] error in
            self?.handle(error: error)
        }
    }
    
    func updateViewModel(with weatherData: WTCityWeatherData) {
        cityViewModel = WTCityViewModel(weatherData: weatherData)
        onUpdate?()
    }
}

//MARK: - Search Bar Delegate
extension WTHomeViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarViewModel?.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            fetchData(for: text)
        }
    }
}

//MARK: - Error Handling
extension WTHomeViewModel {
    func handle(error: Error) {
        print("rev show error alert")
    }
}
