//
//  WTHomeViewController.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import UIKit

class WTHomeViewController: UIViewController {
    @IBOutlet weak var cityView: WTCityView!
    
    var viewModel = WTHomeViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initialLoad()
        viewModel.onUpdate = { [weak self] in
            self?.cityView.configure(with: self?.viewModel.cityViewModel)
        }
    }


}

