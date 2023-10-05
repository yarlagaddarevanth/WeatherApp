//
//  WTAPIService.swift
//  WeatherApp
//
//  Created by Revanth Kumar Yarlagadda on 10/5/23.
//

import Foundation

let kAppID = "4c474428e6871538640cbea4ec4c66ff"

protocol WTAPIService {}

protocol WTCityAPIService {
    func weather(for city: String,
                 onSuccess: @escaping (WTAPIResponse) -> Void,
                 onFailure: @escaping (Error) -> Void)
}

class WTCityAPIServiceImpl: WTCityAPIService {
    func weather(for city: String,
                 onSuccess: @escaping (WTAPIResponse) -> Void,
                 onFailure: @escaping (Error) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(kAppID)") else {
            onFailure(WTError())
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print("rev json respnse \(string)")
            }

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
                        let items = try JSONDecoder().decode(WTAPIResponse.self, from: data)
                        onSuccess(items)
                    } else {
                        onFailure(WTError())
                    }
                } catch {
                    onFailure(WTError())
                }
            }
            
        }
        task.resume()

    }
}
