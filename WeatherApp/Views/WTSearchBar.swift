//
//  WTSearchBar.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/7/23.
//

import UIKit

class WTSearchBar: UISearchBar {

    func configure(with viewModel: WTSearchBarViewModel?) {
        placeholder = viewModel?.placeHolder
    }
}
