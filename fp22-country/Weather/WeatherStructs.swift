//
//  WeatherStructs.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation


public struct Location {
    let city: String
    let country: String
}
public struct Weather {
    let response: WeeklyForecastResponse
    
    init (response: WeeklyForecastResponse) {
        self.response = response
    }
}
// JSON Response
struct WeeklyForecastResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let daily: [DailyForecast]
}
struct DailyForecast: Decodable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    
    let temp: TempForecast
    
//    let pressure: Int
//    let humidity: Int
//    let dew_point: Double
    
    let weather: [WeatherForecast]
    
//    let rain: Double
//    let uvi: Double
}
struct TempForecast: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
struct WeatherForecast: Decodable {
    let main: String
    let description: String
}
