//
//  WeatherService.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import CoreLocation
import Foundation

@available(*, deprecated, message: "Use AsyncWeatherService instead")

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private var weatherCompletionHandler: ((Weather) -> Void)?
    private var geolocCompletionHandler: ((Location) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    public func loadWeatherAndLocationData(weather weatherCompletionHandler: @escaping((Weather)-> ()), location geolocCompletionHandler: @escaping((Location)-> ())) {
        self.weatherCompletionHandler = weatherCompletionHandler
        self.geolocCompletionHandler = geolocCompletionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        
        // Geolocation
        // https://stackoverflow.com/questions/62704004/swiftui-get-city-locality-information-from-users-location
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) {
            placemarks, error -> Void in

            // Place details
            guard let placeMark = placemarks?.first else { return }
            guard let city = placeMark.subAdministrativeArea else { return }
            guard let country = placeMark.country else { return }
            if let geolocCompletionHandler = self.geolocCompletionHandler {
                geolocCompletionHandler(Location(city: city, country: country))
            }
            else {
                print("No location handler")
            }
        }
        
        // Weather
        
        guard let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=hourly,alerts,minutely,current&appid=\(Keys.WEATHER_API_KEY)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else  {return}
        
//        print(urlString)
        guard let url = URL(string: urlString) else {return}
        
        
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard error == nil, let data = data else {return}
//            print(String(decoding: data, as: UTF8.self))
            if let response = try? JSONDecoder().decode(WeeklyForecastResponse.self, from: data) {
                if let weatherCompletionHandler = self.weatherCompletionHandler {
                    weatherCompletionHandler(Weather(response: response))
                }
                else{
                    print("No Weather Handler")
                }
            }
            else {
                print("Failed to decode JSON")
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}



