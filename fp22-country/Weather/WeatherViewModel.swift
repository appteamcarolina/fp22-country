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
    
    init() {
        weatherService = WeatherService()
    }
    
    public func refresh() {
        weatherService.loadWeatherAndLocationData(weather: weatherHandler, location: geolocHandler)
    }
    
    private func geolocHandler(location: Location) {
        print("Location handler: \(location.city), \(location.country)")
        city = location.city
        country = location.country
    }
    
    private func weatherHandler(weather: Weather) {
        print(weather.response)
    }
}
