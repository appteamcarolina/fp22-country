//
//  WeatherViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

public class WeatherViewModel: ObservableObject {
    var locationManager: AsyncLocationManager
    
    //@Published var country = ""
   // @Published var city = ""
   // @Published var dailyForecasts: [DayForecast] = []
    
    
    @Published private(set) var country = WidgetWeatherStore.fetchCountry()
    @Published private(set) var city = WidgetWeatherStore.fetchCity()
    @Published private(set) var dailyForecasts: [DayForecast] = []
    
    init(preview: Bool = false) {
        locationManager = AsyncLocationManager()
        if preview {
            dailyForecasts = WeekForecast.example.daily
            country = "United Kingdom"
            city = "London"
        }
        else {
            refresh()
        }
    }
    
    public func refresh() {
        Task {
            do {
                let authStatus = await locationManager.requestWhenInUseAuthorization()
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
                    WidgetWeatherStore.save(city: self.city, country: self.country, tempForecasts: self.dailyForecasts[0].temp, sky: self.dailyForecasts[0].weather[0])
                }
                
            }
            catch {
                print("Refesh error: ")
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
