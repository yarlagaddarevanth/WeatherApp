//
//  WTCityAPIServiceImpl.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import Foundation

class WTCityAPIURLBuilderImpl: WTCityAPIURLBuilder {
    var cityUrlString: String {
        "\(baseURL)?q=%@&units=imperial&appid=\(kAppID)"
    }
}

class WTCityAPIServiceImpl: WTCityAPIService {
    var urlBuilder: WTCityAPIURLBuilder
    
    init(urlBuilder: WTCityAPIURLBuilder) {
        self.urlBuilder = urlBuilder
    }
    
    func weather(for city: String,
                 onSuccess: @escaping (WTAPIResponse) -> Void,
                 onFailure: @escaping (Error) -> Void) {
        // TODO: Given more time, we can do more detailed and specific errors to handle various types of failures with appropriate descriptions.
        guard !city.isEmpty else {
            onFailure(WTError())
            return
        }
        let urlString = String(format: urlBuilder.cityUrlString, city.replacingOccurrences(of: " ", with: "%20"))
        guard let url = URL(string: urlString) else {
            onFailure(WTError())
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onFailure(error)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onFailure(WTError())
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let item = try JSONDecoder().decode(WTAPIResponse.self, from: data)
                        onSuccess(item)
                    } else {
                        onFailure(WTError())
                    }
                } catch let error {
                    onFailure(error)
                }
            }
        }
        task.resume()
    }
}
