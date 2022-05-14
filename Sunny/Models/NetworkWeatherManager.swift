//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Roman Belov on 11.05.2022.
//  Copyright © 2022 Roman Belov. All rights reserved.
//

import Foundation

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather)->())?
    
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DataTask error: " + error.localizedDescription)
            } else if let weatherData = data {
                if let response = response as? HTTPURLResponse {
                    print("Response code: \(response.statusCode)")
                }
                if let currentWeather = self.jsonParcer(withData: weatherData) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func jsonParcer(withData data: Data)->CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
