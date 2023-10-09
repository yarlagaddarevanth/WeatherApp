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
        viewModel?.showSpinner = showSpinner(show:)
        viewModel?.showGenericErrorAlert = showGenericErrorAlert
        
        // Search bar
        searchBar.delegate = viewModel
        searchBar.configure(with: viewModel?.searchBarViewModel)
    }
    
}

//MARK: - Handle spinner
extension WTHomeViewController {
    fileprivate func showSpinner(show: Bool) {
        if show {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
        activityIndicatorView.isHidden = !show
    }
}


//MARK: - Handle error alert
extension WTHomeViewController {
    fileprivate func showGenericErrorAlert() {
        //TODO: Upgrade this method to receive specific error type and show accurate alerts.
        //TODO: Localize
        let alert = UIAlertController(title: "Something went wrong.",
                                      message: "Please try again.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        present(alert,
                animated: true,
                completion: nil)
    }
}

