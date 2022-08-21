//
//  CurrentWeather.swift
//  Sunny
//
//  Created by Roman Belov on 11.05.2022.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature.rounded())
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature.rounded())
    }
    
    let conditionCode: Int
    var conditionIconString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...771: return "cloud.fog.fill"
        case 781: return "tornado"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    let windSpeed: Double
    var windSpeedString: String {
        return String(format: "%.0f", windSpeed.rounded())
    }
    
    let windDirection: Int
    var windDirectionString: String {
        switch windDirection {
        case 0...11: return "N"
        case 12...33: return "NNE"
        case 34...56: return "NE"
        case 57...78: return "ENE"
        case 79...101: return "E"
        case 102...123: return "ESE"
        case 124...146: return "SE"
        case 147...168: return "SSE"
        case 169...191: return "S"
        case 192...213: return "SSW"
        case 214...236: return "SW"
        case 237...258: return "WSW"
        case 259...281: return "W"
        case 282...303: return "WNW"
        case 304...326: return "NW"
        case 327...348: return "NNW"
        case 349...360: return "N"
        default: return ""
        }
    }
    
    init? (currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
        windSpeed = currentWeatherData.wind.speed
        windDirection = currentWeatherData.wind.deg
    }
}
