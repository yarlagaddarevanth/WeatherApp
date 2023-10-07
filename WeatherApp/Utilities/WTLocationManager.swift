//
//  WTLocationManager.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/7/23.
//

import Foundation
import CoreLocation

class WTLocationManager: NSObject {
    private var locationManager: CLLocationManager
    var onReceivedCurrentCity: ((String) -> Void)?
    var onFailureToReceiveCity: (() -> Void)?
    var authorizationGranted: Bool {
        let status = locationManager.authorizationStatus

        switch status {
        case .authorized,
             .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }

    override init() {
        let locationManager = CLLocationManager()
        self.locationManager = locationManager
        super.init()

        setup()
    }
    
    private func setup() {
        locationManager.delegate = self
    }
                
    func requestAuthorizationAndLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }

}

extension WTLocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if authorizationGranted {
            requestLocation()
        } else {
            onFailureToReceiveCity?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            location.geocode { [weak self] placemark, error in
                if let city = placemark?.first?.locality {
                    self?.onReceivedCurrentCity?(city)
                } else {
                    // This handles error case too.
                    self?.onFailureToReceiveCity?()
                }
            }
        } else {
            onFailureToReceiveCity?()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        onFailureToReceiveCity?()
    }
}

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}
