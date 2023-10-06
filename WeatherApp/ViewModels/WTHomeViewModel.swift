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
    let dataProvider: WTCityWeatherDataProvider
    
    var onUpdate: (() -> Void)?
    
    init(dataProvider: WTCityWeatherDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func initialLoad() {
        if let latestSearchTextAvailable = WTSearchCacheManager.shared.retrieveLatest() {
            fetchData(for: latestSearchTextAvailable)
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
