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
            ScrollView (.horizontal, showsIndicators: false) {
                 HStack {
                     ForEach(vm.dailyForecasts, id: \.dt) {
                         dailyForecast in
                         NavigationLink {
                             FullDayWeatherView(dayWeather: dailyForecast)
                         } label: {
                             SummaryDayWeatherView(dayWeather: dailyForecast, city: vm.city)
                                 .frame(width:390)
                                // .cornerRadius(10)
                         }
                         .buttonStyle(.plain)

                     }
                 }
                 .frame(maxHeight:.infinity)
            }
            .ignoresSafeArea()
        }
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(preview: true).preferredColorScheme(.dark).navigationBarHidden(true)
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
