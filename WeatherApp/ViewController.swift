//
//  ViewController.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WTCityAPIServiceImpl(urlBuilder: WTCityAPIURLBuilderImpl()).weather(for: "london") { response in
            
        } onFailure: { error in
            
        }

    }


}

