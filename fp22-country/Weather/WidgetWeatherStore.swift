//
//  WidgetWeatherStore.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/18/22.
//

import Foundation


struct WidgetWeatherStore {
    static func save(city: String, country: String, tempForecasts: TempForecast) -> Void{
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(country, forKey: "country")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempForecasts){
            UserDefaults.standard.set(encoded, forKey: "weather")
        }
    }
    
    static func fetchCity() -> String {
        UserDefaults.standard.string(forKey: "city") ?? "Chapel Hill"
    }
    static func fetchCountry() -> String {
        UserDefaults.standard.string(forKey: "country") ?? ""
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
    
    
}
