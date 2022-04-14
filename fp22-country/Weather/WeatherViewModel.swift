//
//  WeatherViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    @Published var locationManager: AsyncLocationManager
    
    @Published var country = ""
    @Published var city = ""
    @Published var dailyForecasts: [DayForecast] = []
    
    init() {
        locationManager = AsyncLocationManager()
        refresh()
    }
    
    public func refresh() {
        Task {
            do {
                let coordinates = try await locationManager.requestLocation()
                guard let coordinates = coordinates else {
                    print("coordinates not available")
                    return
                }
                let location = await AsyncWeatherService.requestGeoLoc(forCoordinates: coordinates)
                let weather = try await AsyncWeatherService.requestWeather(forCoordinates: coordinates)
                
                DispatchQueue.main.async {
                    self.country = location.country
                    self.city = location.city
                    self.dailyForecasts = weather.daily
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    private func geolocHandler(location: Location) {
//        print("Location handler: \(location.city), \(location.country)")
//        DispatchQueue.main.async {
//            self.city = location.city
//            self.country = location.country
//        }
//    }
//
//    private func weatherHandler(weather: Weather) {
////        print(weather.response)
//        print(weather.response.daily.count)
//        DispatchQueue.main.async {
//            self.dailyForecasts = weather.response.daily
//        }
//    }
}
