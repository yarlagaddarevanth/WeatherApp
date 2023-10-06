//
//  WTSearchCacheManager.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

class WTSearchCacheManager {
    static let shared = WTSearchCacheManager()
    
    private init() {}
    
    private let kLatestSearch = "LatestSearchText"
    
    func saveLatest(text: String) {
        UserDefaults.standard.set(text, forKey: kLatestSearch)
    }
    
    func retrieveLatest() -> String? {
        if let text = UserDefaults.standard.value(forKey: kLatestSearch) as? String {
            return text
        }
        return nil
    }

}
