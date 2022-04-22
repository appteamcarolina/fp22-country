//
//  WidgetWeatherStore.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/18/22.
//

import Foundation


struct WidgetWeatherStore {
    static func save(city: String, country: String, weekForecast: WeekForecast, tempForecasts: TempForecast, sky: WeatherForecast) -> Void{
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(country, forKey: "country")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempForecasts){
            UserDefaults.standard.set(encoded, forKey: "weather")
        }
        if let encoded = try? encoder.encode(sky){
            UserDefaults.standard.set(encoded, forKey: "sky")
        }
        if let encoded = try? encoder.encode(weekForecast){
            UserDefaults.standard.set(encoded, forKey: "weekForecast")
        }
    }
    
    static func fetchCity() -> String {
        UserDefaults.standard.string(forKey: "city") ?? "Chapel Hill"
    }
    static func fetchCountry() -> String {
        UserDefaults.standard.string(forKey: "country") ?? ""
    }
    static func fetchWeekForecast() -> WeekForecast? {
        if let savedData = UserDefaults.standard.data(forKey: "weekForecast") {
            return try? JSONDecoder().decode(WeekForecast.self, from: savedData)
        }
        return nil
    }
    static func fetchForecast() -> TempForecast{
        if let savedData = UserDefaults.standard.object(forKey: "weather"){
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(TempForecast.self, from: savedData as! Data){
                return loadedData
            }
        }
        return .placeholder()
    }
    
    static func fetchSky() -> WeatherForecast{
        if let savedData = UserDefaults.standard.object(forKey: "sky"){
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(WeatherForecast.self, from: savedData as! Data){
                return loadedData
            }
        }
        return .placeholder()

    }
    
    
}
