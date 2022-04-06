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
                        Text(dailyForecast.weather.first?.main ?? "")
                    }
                }
            }
        }.onAppear {
            vm.refresh()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
