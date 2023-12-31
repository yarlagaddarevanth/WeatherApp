//
//  WTWeatherAPIModel.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import Foundation

struct WTAPIResponse: Codable {
    let id: Double?
    let name: String?
    let weather: [WTAPIWeather]?
    let main: WTAPIMain?
}

struct WTAPIWeather: Codable {
    let id: Double?
    let main: String?
    let description: String?
    let icon: String?
}

struct WTAPIMain: Codable {
    let temp: Double?
    let humidity: Double?
}
