//
//  WTHomeViewController.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import UIKit

class WTHomeViewController: UIViewController {
    @IBOutlet weak var cityView: WTCityView!
    
    var viewModel: WTHomeViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WTCityAPIServiceImpl(urlBuilder: WTCityAPIURLBuilderImpl()).weather(for: "london") { [weak self] response in
            let viewModel = WTCityViewModel(heading: response.name,
                                            subHeading: response.weather.first?.main,
                                            description: response.weather.first?.description)
            self?.cityView.configure(with: viewModel)
        } onFailure: { error in
            
        }

    }


}

