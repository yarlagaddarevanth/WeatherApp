//
//  WTHomeViewModel.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

struct WTHomeViewModel {
    let cityViewModel: WTCityViewModel
    
}

struct WTCityViewModel {
    let heading: String?
    let subHeading: String?
    let description: String?
}
