//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by Roman Belov on 11.05.2022.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    var onCompletion: ((CurrentWeather)->())?
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
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
        }.resume()
    }
    
    fileprivate func jsonParcer(withData data: Data)->CurrentWeather? {
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
