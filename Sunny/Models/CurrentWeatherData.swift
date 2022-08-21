//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by Roman Belov on 11.05.2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
}


struct Weather: Codable {
    let id: Int
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
