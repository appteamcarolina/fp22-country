//
//  WidgetWeatherStore.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/18/22.
//

import Foundation


struct WeatherStore {
    static let userDefaults = UserDefaults(suiteName: "group.com.fp22-country.contents")!
    
    static func save(city: String, country: String, weekForecast: WeekForecast, tempForecasts: TempForecast, sky: WeatherForecast) -> Void{
        userDefaults.set(city, forKey: "city")
        userDefaults.set(country, forKey: "country")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempForecasts){
            userDefaults.set(encoded, forKey: "weather")
        }
        if let encoded = try? encoder.encode(sky){
            userDefaults.set(encoded, forKey: "sky")
        }
        if let encoded = try? encoder.encode(weekForecast){
            userDefaults.set(encoded, forKey: "weekForecast")
        }
    }
    
    static func fetchCity() -> String {
        userDefaults.string(forKey: "city") ?? "Chapel Hill"
    }
    static func fetchCountry() -> String {
        userDefaults.string(forKey: "country") ?? ""
    }
    static func fetchWeekForecast() -> WeekForecast? {
        if let savedData = userDefaults.data(forKey: "weekForecast") {
            return try? JSONDecoder().decode(WeekForecast.self, from: savedData)
        }
        return nil
    }
    static func fetchForecast() -> TempForecast{
        if let savedData = userDefaults.object(forKey: "weather"){
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(TempForecast.self, from: savedData as! Data){
                return loadedData
            }
        }
        return .placeholder()
    }
    
    static func fetchSky() -> WeatherForecast{
        if let savedData = userDefaults.object(forKey: "sky"){
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(WeatherForecast.self, from: savedData as! Data){
                return loadedData
            }
        }
        return .placeholder()

    }
    
    
}
