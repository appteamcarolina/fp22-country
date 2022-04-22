//
//  WeatherView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var vm: WeatherViewModel
    
    
    init(preview: Bool = false) {
        _vm = StateObject<WeatherViewModel>(wrappedValue: WeatherViewModel(preview: preview))
    }
    
    var body: some View {
        VStack {
            GroupBox {
                HStack {
                    VStack(alignment:.leading) {
                        Text("Country: \(vm.country)")
                        Text("City: \(vm.city)")
                    }
                    Spacer()
                }
                
            } label: {
                Label("Location", systemImage: "location")
            }
            ScrollView (.horizontal, showsIndicators: false) {
                 HStack {
                     ForEach(vm.dailyForecasts, id: \.dt) {
                         dailyForecast in
                         NavigationLink {
                             FullDayWeatherView(dayWeather: dailyForecast)
                         } label: {
                             SummaryDayWeatherView(dayWeather: dailyForecast)
                                 .frame(width: 300)
                                 .cornerRadius(10)
                         }.buttonStyle(.plain)
                         
                     }
                 }.frame(maxHeight:.infinity)
            }
        }
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(preview: true).preferredColorScheme(.dark)
        }
    }
}
