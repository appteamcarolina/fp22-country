//
//  DayWeatherView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import SwiftUI

struct FullDayWeatherView: View {
    let dayWeather: DayForecast
    
    var body: some View {
        ScrollView {
            VStack {
                Text(WeatherUtils.formatUnixWeekDayAndDate(dayWeather.dt)).font(.largeTitle)
                
                Label(dayWeather.weather.first?.main ?? "N/A", systemImage: WeatherUtils.systemImageMap[dayWeather.weather.first?.main ?? "N/A"] ?? "questionmark.circle").font(.title)
                
                Text(dayWeather.weather.first?.description.capitalized ?? "N/A")
                
                GroupBox {
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Label("Sunrise: " + WeatherUtils.formatUnixTime(dayWeather.sunrise), systemImage: "sunrise")
                            Label("Sunset: " + WeatherUtils.formatUnixTime( dayWeather.sunset), systemImage: "sunset")
                            Label("Moonrise: " + WeatherUtils.formatUnixTime(dayWeather.sunrise), systemImage: "moon.fill")
                            Label("Moonset: " + WeatherUtils.formatUnixTime( dayWeather.sunset), systemImage: "moon")
                        }
                        Spacer()
                    }
                } label: {
                    Label("Sun and Moon", systemImage: "sun.and.horizon")
                }
                
                GroupBox {
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Label("Pressure: \(dayWeather.pressure) hPa", systemImage: "barometer")
                            Label("Humidity: \(dayWeather.humidity)%", systemImage: "humidity")
                            Label("Wind Speed: \(dayWeather.wind_speed, specifier: "%.1f") m/s", systemImage: "wind")
                            Label("Wind Deg: \(dayWeather.humidity)°", systemImage: "wind")
                        }
                        Spacer()
                    }
                } label: {
                    Label("Basic Info", systemImage: "info.circle")
                }
                
                GroupBox {
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Label("Morn: \(dayWeather.feels_like.morn, specifier: "%.2f")°C", systemImage: "sunrise")
                            Label("Day: \(dayWeather.feels_like.day, specifier: "%.2f")°C", systemImage: "sun.max")
                            Label("Eve: \(dayWeather.feels_like.eve, specifier: "%.2f")°C", systemImage: "sunset")
                            Label("Night: \(dayWeather.feels_like.night, specifier: "%.2f")°C", systemImage: "moon")
                        }
                        Spacer()
                    }
                } label: {
                    Label("Feels Like", systemImage: "person")
                }
                
//                GroupBox {
//                    Divider()
//                    Text(dayWeather.weather.first?.main ?? "")
//                    Text(dayWeather.weather.first?.description.capitalized ?? "")
//                    Image(systemName: WeatherUtils.systemImageMap[dayWeather.weather.first?.main ?? ""] ?? "questionmark.circle")
//                } label: {
//                    Label("Weather", systemImage: "cloud")
//                }
                
                GroupBox {
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Label("High: \(dayWeather.temp.max, specifier: "%.2f")°C", systemImage: "chevron.up")
                            Label("Low: \(dayWeather.temp.min, specifier: "%.2f")°C", systemImage: "chevron.down")
                            Label("Morn: \(dayWeather.temp.morn, specifier: "%.2f")°C", systemImage: "sunrise")
                            Label("Day: \(dayWeather.temp.day, specifier: "%.2f")°C", systemImage: "sun.max")
                            Label("Eve: \(dayWeather.temp.eve, specifier: "%.2f")°C", systemImage: "sunset")
                            Label("Night: \(dayWeather.temp.night, specifier: "%.2f")°C", systemImage: "moon")
                        }
                        Spacer()
                    }
                    
                } label: {
                    Label("Temperature", systemImage: "thermometer")
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding([.bottom, .leading, .trailing])
        .padding(.top, 50)
        .ignoresSafeArea()
        .fullscreenBackground(WeatherUtils.gradientMap[dayWeather.weather.first?.main ?? "N/A"] ?? WeatherUtils.clearGradient)
    }
    

}

struct DayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        FullDayWeatherView(dayWeather: WeekForecast.example2.daily.first!).preferredColorScheme(.dark)
    }
}
