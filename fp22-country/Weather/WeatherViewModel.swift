//
//  WeatherViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    let weatherService: WeatherService
    
    init() {
        weatherService = WeatherService()
    }
    
    public func refresh() {
        weatherService.loadWeatherAndLocationData(weather: weatherHandler, location: geolocHandler)
    }
    
    private func geolocHandler(location: Location) {
        print("Location handerl: \(location.country), \(location.country)")

    }
    
    private func weatherHandler(weather: Weather) {
        print(weather.response)
    }
}
