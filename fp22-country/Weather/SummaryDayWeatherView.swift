//
//  SummaryDayWeatherView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import SwiftUI

struct SummaryDayWeatherView: View {
    let dayWeather: DayForecast
    
    
    var body: some View {
        VStack {
            Text(WeatherUtils.formatUnixWeekDay(dayWeather.dt)).font(.largeTitle)
            
            Label(dayWeather.weather.first?.main ?? "N/A", systemImage: WeatherUtils.systemImageMap[dayWeather.weather.first?.main ?? "N/A"] ?? "questionmark.circle").font(.title)
            
            Text(dayWeather.weather.first?.description.capitalized ?? "N/A")
            
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
            
            GroupBox {
                Divider()
                HStack {
                    VStack(alignment:.leading) {
                        Text("Day: \(dayWeather.temp.day, specifier: "%.2f")°C")
                        Text("High: \(dayWeather.temp.max, specifier: "%.2f")°C")
                        Text("Low: \(dayWeather.temp.min, specifier: "%.2f")°C")
                    }
                    Spacer()
                }
                
            } label: {
                Label("Temperature", systemImage: "thermometer")
            }
            
        }.padding().fullscreenBackground(WeatherUtils.gradientMap[dayWeather.weather.first?.main ?? "N/A"] ?? WeatherUtils.clearGradient)
    }
}

struct SummaryDayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryDayWeatherView(dayWeather: WeekForecast.example2.daily.first!).preferredColorScheme(.dark)
    }
}
