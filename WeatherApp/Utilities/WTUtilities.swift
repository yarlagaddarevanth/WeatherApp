//
//  WTUtilities.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

//MARK: - String
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
