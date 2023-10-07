//
//  WTHomeViewController.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import UIKit

class WTHomeViewController: UIViewController {
    @IBOutlet weak var cityView: WTCityView!
    @IBOutlet weak var searchBar: WTSearchBar!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var viewModel: WTHomeViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        // View Model setup
        let apiService = WTCityAPIServiceImpl(urlBuilder: WTCityAPIURLBuilderImpl())
        let dataProvider = WTCityWeatherDataProviderImpl(apiService: apiService)

        viewModel = WTHomeViewModel(dataProvider: dataProvider)
        viewModel?.initialLoad()
        viewModel?.onUpdate = { [weak self] in
            self?.cityView.configure(with: self?.viewModel?.cityViewModel)
            self?.searchBar.configure(with: self?.viewModel?.searchBarViewModel)
        }
        
        activityIndicatorView.isHidden = true
        viewModel?.showSpinner = { [weak self] show in
            if show {
                self?.activityIndicatorView.startAnimating()
            } else {
                self?.activityIndicatorView.stopAnimating()
            }
            self?.activityIndicatorView.isHidden = !show
        }
    
        // Search bar
        searchBar.delegate = viewModel
        searchBar.configure(with: viewModel?.searchBarViewModel)
    }
    
    func showSpinner() {
        
    }
}

