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
            ScrollViewReader { proxy in
                ScrollView (.horizontal, showsIndicators: false) {
                     HStack {
                         ForEach(vm.dailyForecasts, id: \.dt) {
                             dailyForecast in
                             NavigationLink {
                                 FullDayWeatherView(dayWeather: dailyForecast)
                             } label: {
                                 SummaryDayWeatherView(dayWeather: dailyForecast, city: vm.city)
                                 .frame(maxHeight:.infinity)
                                 .frame(width: geometry.size.width)
                                    // .cornerRadius(10)
                             }
                             .buttonStyle(.plain)
                             .id(dailyForecast.dt)
                         }
                     }
                     
                }
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
                    .padding(.top, 30)
                    .padding()
                }
                .overlay(alignment:.bottom) {
                    HStack(spacing: 15) {
                        ForEach(vm.dailyForecasts, id: \.dt) {
                            dailyForecast in
                            Button {
                                withAnimation {
                                    proxy.scrollTo(dailyForecast.dt)
                                }
                            } label: {
                            VStack {
                                Text(WeatherUtils.formatUnixShortWeekDay(dailyForecast.dt))
                                Text("\(dailyForecast.temp.day, specifier: "%.0f")")
                                Image(systemName: WeatherUtils.systemImageMap[dailyForecast.weather.first?.main ?? "N/A"] ?? "questionmark.circle").frame(height:5)
                            }
                            }.buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 30)
                    .padding()
                }
            }
//            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(preview: true).preferredColorScheme(.dark).navigationBarHidden(true)
        }
        .previewInterfaceOrientation(.portrait)
    }
}
