//
//  AsyncWeatherService.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation
import CoreLocation

struct AsyncWeatherService {
    public static func requestGeoLoc(forCoordinates coordinates: CLLocation) async -> Location {
        // Geolocation
        // https://stackoverflow.com/questions/62704004/swiftui-get-city-locality-information-from-users-location
        let geoCoder = CLGeocoder()
        let geoLoc: Location = await withCheckedContinuation({ continuation in
            geoCoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)) {
                placemarks, error -> Void in
                // Place details
                guard let placeMark = placemarks?.first else { return }
                guard let city = placeMark.subAdministrativeArea else { return }
                guard let country = placeMark.country else { return }
                
                continuation.resume(returning: Location(city: city, country: country))
            }
        })
        return geoLoc
    }
    public static func requestWeather(forCoordinates coordinates: CLLocation) async throws -> WeekForecast{
        // Weather
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/onecall"
        
        let query = [
            URLQueryItem(name: "lat", value: "\(coordinates.coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinates.coordinate.longitude)"),
            URLQueryItem(name: "exclude", value: "hourly,alerts,minutely,current"),
            URLQueryItem(name: "appid", value: "\(Keys.WEATHER_API_KEY)"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        components.queryItems = query
        
//        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=hourly,alerts,minutely,current&appid=\(Keys.WEATHER_API_KEY)&units=metric"
//            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
//        print(urlString)
//        let url = URL(string: urlString)!
        
        let request = URLRequest(url: components.url!)
//        print(components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Status code not 200") }
        let decodedData = try JSONDecoder().decode(WeekForecast.self, from: data)
        return decodedData
    }
}


