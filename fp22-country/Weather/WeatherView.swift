//
//  WeatherView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var vm = WeatherViewModel()
    
    var body: some View {
        
        Form {
            Section("Location"){
                Text("Country: \(vm.country)")
                Text("City: \(vm.city)")
            }
            Section("Weather") {
                List {
                    ForEach(vm.dailyForecasts, id: \.dt) {
                        dailyForecast in
                        VStack(alignment:.leading) {
                            Text(formatDate(date:Date(timeIntervalSince1970: dailyForecast.dt)))
                            Text("Sunrise: " + formatTime(date:Date(timeIntervalSince1970: dailyForecast.sunrise)))
                            Text("Sunset: " + formatTime(date:Date(timeIntervalSince1970: dailyForecast.sunset)))

                            
                            
                            Text(dailyForecast.weather.first?.main ?? "")
                            Text("Temperature: \(dailyForecast.temp.day, specifier: "%.2f")°C")
                        }
                        
                    }
                }
            }
            Section("Horizontal scroll") {
                ScrollView (.horizontal, showsIndicators: false) {
                     HStack {
                         //contents
                     }
                }.frame(height: 200)
            }
        }.onAppear {
            vm.refresh()
        }
    }
    // https://stackoverflow.com/questions/50712354/converting-utc-date-time-to-local-date-time-in-ios
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: date)
    }
    func formatTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
