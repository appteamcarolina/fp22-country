//
//  WeatherViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    let weatherService: WeatherService
    
    @Published var country = ""
    @Published var city = ""
    @Published var dailyForecasts: [DailyForecast] = []
    
    init() {
        weatherService = WeatherService()
    }
    
    public func refresh() {
        weatherService.loadWeatherAndLocationData(weather: weatherHandler, location: geolocHandler)
    }
    
    private func geolocHandler(location: Location) {
        print("Location handler: \(location.city), \(location.country)")
        DispatchQueue.main.async {
            self.city = location.city
            self.country = location.country
        }
    }
    
    private func weatherHandler(weather: Weather) {
//        print(weather.response)
        print(weather.response.daily.count)
        DispatchQueue.main.async {
            self.dailyForecasts = weather.response.daily
        }
    }
}
