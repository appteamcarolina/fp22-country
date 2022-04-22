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
        GeometryReader { geometry in
           // GroupBox {
             //   HStack {
               //     VStack(alignment:.leading) {
                 //       Text("Country: \(vm.country)")
                   //     Text("City: \(vm.city)")
                 //   }
               // Spacer()
                //}
                
         //   } label: {
           //     Label(vm.city, systemImage: "location")
            //}
//            ScrollView (.horizontal, showsIndicators: false) {
//                 HStack {
//                     ForEach(vm.dailyForecasts, id: \.dt) {
//                         dailyForecast in
//                         NavigationLink {
//                             FullDayWeatherView(dayWeather: dailyForecast)
//                         } label: {
//                             SummaryDayWeatherView(dayWeather: dailyForecast, city: vm.city)
//                                 .frame(width:390)
//                                // .cornerRadius(10)
//                         }.buttonStyle(.plain)
//
//                     }
//                 }.frame(maxHeight:.infinity)
//            }
            
            TabView {
                ForEach(vm.dailyForecasts, id: \.dt) {
                    dailyForecast in
                    NavigationLink {
                        FullDayWeatherView(dayWeather: dailyForecast)
                    } label: {
                        SummaryDayWeatherView(dayWeather: dailyForecast, city: vm.city)
                    }
                    .buttonStyle(.plain)
                    .tabItem {
                        Label(dailyForecast.weather.first?.main ?? "N/A", systemImage: WeatherUtils.systemImageMap[dailyForecast.weather.first?.main ?? "N/A"] ?? "questionmark.circle")
                    }
                }
                .frame(height: geometry.size.height+60)

            }
            .tabViewStyle(.page)
            .overlay(alignment:.topTrailing) {
                HStack(spacing: 15) {
                    NavigationLink {
                        AIView()
                    } label: {
                        Image(systemName: "brain")
                    }.buttonStyle(.plain)
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                    }.buttonStyle(.plain)
                }
                .font(.title)
                .padding(.top, 60)
                .padding()
            }
        }
        .ignoresSafeArea()
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(preview: true).preferredColorScheme(.dark).navigationBarHidden(true)
        }
    }
}
