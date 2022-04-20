//
//  WeatherStructs.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation


public struct Location {
    let city: String
    let country: String
}

extension Location {
    static func placeHolder() -> Location {
        Location(city: "Chapel Hill", country: "USA")
    }
}

public struct Weather {
    let response: WeekForecast
    
    init (response: WeekForecast) {
        self.response = response
    }
}
// JSON Response
struct WeekForecast: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let daily: [DayForecast]
}
extension WeekForecast {
    static let example2String = """
        {"lat":51.51,"lon":-0.1337,"timezone":"Europe/London","timezone_offset":3600,"daily":[{"dt":1649937600,"sunrise":1649912824,"sunset":1649962451,"moonrise":1649952120,"moonset":1649911440,"moon_phase":0.42,"temp":{"day":17.72,"min":9.03,"max":18.4,"night":12.96,"eve":15.8,"morn":9.28},"feels_like":{"day":16.93,"night":12.53,"eve":15.24,"morn":9.28},"pressure":1022,"humidity":53,"dew_point":8.08,"wind_speed":2.07,"wind_deg":240,"wind_gust":4.31,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":60,"pop":0.02,"uvi":0},{"dt":1650024000,"sunrise":1649999094,"sunset":1650048951,"moonrise":1650043320,"moonset":1649998680,"moon_phase":0.45,"temp":{"day":19.6,"min":10.22,"max":20.19,"night":13.25,"eve":16.28,"morn":10.63},"feels_like":{"day":18.82,"night":12.82,"eve":15.71,"morn":10.02},"pressure":1026,"humidity":46,"dew_point":7.63,"wind_speed":2.44,"wind_deg":119,"wind_gust":3.31,"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":46,"pop":0.06,"uvi":0},{"dt":1650110400,"sunrise":1650085366,"sunset":1650135452,"moonrise":1650134760,"moonset":1650085920,"moon_phase":0.5,"temp":{"day":17.36,"min":9.58,"max":18.03,"night":11.33,"eve":14.21,"morn":9.92},"feels_like":{"day":16.51,"night":10.42,"eve":13.41,"morn":9.32},"pressure":1029,"humidity":52,"dew_point":7.51,"wind_speed":3.88,"wind_deg":92,"wind_gust":5.52,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0,"uvi":0},{"dt":1650193200,"sunrise":1650171638,"sunset":1650221952,"moonrise":1650226320,"moonset":1650173280,"moon_phase":0.52,"temp":{"day":16.63,"min":9.85,"max":16.63,"night":11.7,"eve":13.99,"morn":9.92},"feels_like":{"day":15.65,"night":10.47,"eve":12.62,"morn":9.4},"pressure":1021,"humidity":50,"dew_point":6.08,"wind_speed":4.35,"wind_deg":154,"wind_gust":6.75,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0,"uvi":0},{"dt":1650279600,"sunrise":1650257910,"sunset":1650308453,"moonrise":1650318060,"moonset":1650260820,"moon_phase":0.56,"temp":{"day":16.54,"min":9.22,"max":16.54,"night":10.71,"eve":13.47,"morn":9.22},"feels_like":{"day":15.19,"night":9.48,"eve":12.13,"morn":8.07},"pressure":1010,"humidity":36,"dew_point":1.24,"wind_speed":4.16,"wind_deg":139,"wind_gust":7.47,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":73,"pop":0,"uvi":0},{"dt":1650366000,"sunrise":1650344184,"sunset":1650394953,"moonrise":0,"moonset":1650348720,"moon_phase":0.6,"temp":{"day":13.47,"min":8.34,"max":13.47,"night":8.34,"eve":11.09,"morn":9.06},"feels_like":{"day":11.97,"night":5.64,"eve":9.61,"morn":7.61},"pressure":1009,"humidity":42,"dew_point":0.84,"wind_speed":5.7,"wind_deg":79,"wind_gust":12.31,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":100,"pop":0.08,"uvi":0},{"dt":1650452400,"sunrise":1650430459,"sunset":1650481454,"moonrise":1650409800,"moonset":1650437160,"moon_phase":0.64,"temp":{"day":8.72,"min":5.85,"max":9.11,"night":8.38,"eve":8.79,"morn":5.85},"feels_like":{"day":6,"night":5.88,"eve":6.56,"morn":2.78},"pressure":1015,"humidity":77,"dew_point":4.83,"wind_speed":5.45,"wind_deg":29,"wind_gust":11.34,"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":72,"pop":0.04,"uvi":0},{"dt":1650538800,"sunrise":1650516734,"sunset":1650567954,"moonrise":1650501120,"moonset":1650526440,"moon_phase":0.68,"temp":{"day":13.91,"min":6.21,"max":13.91,"night":9.43,"eve":11.62,"morn":7.03},"feels_like":{"day":12.61,"night":7.42,"eve":10.43,"morn":4.32},"pressure":1014,"humidity":48,"dew_point":3.21,"wind_speed":5.63,"wind_deg":47,"wind_gust":9.96,"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":98,"pop":0,"uvi":0}]}
    """
    
    static let example = WeekForecast(lat: 51.50998, lon: -0.1337, timezone: "Europe/London", daily: [.clouds, .clear, .snow, .rain, .thunderstorm, .drizzle])
    static var example2: WeekForecast {
        var decoded: WeekForecast? = nil
        do {
            decoded = try JSONDecoder().decode(WeekForecast.self, from: example2String.data(using: .utf8)!)
        }
        catch {
            print(error.localizedDescription)
        }
        return decoded!
    }
}
struct DayForecast: Decodable{
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let moonrise: Double
    let moonset: Double
    
    let temp: TempForecast
    
    let pressure: Int
    let humidity: Int
//    let dew_point: Double
    
    
    let wind_speed: Double
    let wind_deg: Int
    
    let feels_like: FeelsLikeForecast
    
    let weather: [WeatherForecast]
    
}
extension DayForecast {
    static let clouds = DayForecast(dt: Date().advanced(by: 24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Clouds", description: "clouds")])
    static let clear = DayForecast(dt: Date().advanced(by: 2*24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Clear", description: "clear")])
    static let snow = DayForecast(dt: Date().advanced(by: 3*24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Snow", description: "snow")])
    static let rain = DayForecast(dt: Date().advanced(by: 4*24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Rain", description: "rain")])
    static let thunderstorm = DayForecast(dt: Date().advanced(by: 5*24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Thunderstorm", description: "thunderstorm")])
    static let drizzle = DayForecast(dt: Date().advanced(by: 6*24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Drizzle", description: "drizzle")])
}

extension DayForecast {
    static func placeholder() -> DayForecast {
        DayForecast(dt: Date().advanced(by: 24*60*60).timeIntervalSince1970, sunrise: Date().timeIntervalSince1970, sunset: Date().timeIntervalSince1970, moonrise: Date().timeIntervalSince1970, moonset: Date().timeIntervalSince1970, temp: TempForecast(day: 25.0, min: 25.0, max: 25.0, night: 25.0, eve: 25.0, morn: 25.0), pressure: 10, humidity: 10, wind_speed: 10, wind_deg: 10, feels_like: FeelsLikeForecast(morn: 25.0, day: 25.0, eve: 25.0, night: 25.0), weather: [WeatherForecast(main: "Clouds", description: "clouds")])
    }
}
struct FeelsLikeForecast: Decodable {
    let morn: Double
    let day: Double
    let eve: Double
    let night: Double
}
struct TempForecast: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
extension TempForecast {
    static func placeholder() -> TempForecast {
        TempForecast(day: 70.0, min: 70.0, max: 70.0, night: 70.0, eve: 70.0, morn: 70.0)
    }
}
struct WeatherForecast: Codable {
    let main: String
    let description: String
}

extension WeatherForecast {
    static func placeholder() -> WeatherForecast {
        WeatherForecast(main: "Drizzle", description: "Drizzle")
    }
}
