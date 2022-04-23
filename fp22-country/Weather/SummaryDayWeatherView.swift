//
//  SummaryDayWeatherView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import SwiftUI

struct SummaryDayWeatherView: View {
    let dayWeather: DayForecast
    let city: String
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
            Text(WeatherUtils.formatUnixWeekDay(dayWeather.dt)).font(.largeTitle)
            Label(dayWeather.weather.first?.main ?? "N/A", systemImage: WeatherUtils.systemImageMap[dayWeather.weather.first?.main ?? "N/A"] ?? "questionmark.circle").font(.title)
            
         //   Text(dayWeather.weather.first?.description.capitalized ?? "N/A")
            Text(city)
                .fontWeight(.bold)
            
           
            
            SummaryTemperatureView(dayWeather:dayWeather)
//            SummaryFeelsLikeView(dayWeather:dayWeather)
            AIAppView(dayWeather:dayWeather)
//            Spacer()
            
//            GroupBox {
//                Divider()
//                HStack {
//                    VStack(alignment:.leading) {
//                        Text("Day: \(dayWeather.temp.day, specifier: "%.2f")°C")
//                        Text("High: \(dayWeather.temp.max, specifier: "%.2f")°C")
//                        Text("Low: \(dayWeather.temp.min, specifier: "%.2f")°C")
//                    }
//                    Spacer()
//                }
//
//            } label: {
//                Label("Temperature", systemImage: "thermometer")
//            }.groupBoxStyle(TransparentGroupBox())
//
//            GroupBox {
//                Divider()
//                HStack {
//                    VStack(alignment:.leading) {
//                        Label("Morn: \(dayWeather.feels_like.morn, specifier: "%.2f")°C", systemImage: "sunrise")
//                        Label("Day: \(dayWeather.feels_like.day, specifier: "%.2f")°C", systemImage: "sun.max")
//                        Label("Eve: \(dayWeather.feels_like.eve, specifier: "%.2f")°C", systemImage: "sunset")
//                        Label("Night: \(dayWeather.feels_like.night, specifier: "%.2f")°C", systemImage: "moon")
//                    }
//                    Spacer()
//                }
//            } label: {
//                Label("Feels Like", systemImage: "person")
//            }.groupBoxStyle(TransparentGroupBox())
//
//            GroupBox {
//                Divider()
//                HStack {
//                    VStack(alignment:.leading) {
//                        Text("Day: \(dayWeather.temp.day, specifier: "%.2f")°C")
//                        Text("High: \(dayWeather.temp.max, specifier: "%.2f")°C")
//                        Text("Low: \(dayWeather.temp.min, specifier: "%.2f")°C")
//                    }
//                    Spacer()
//                }
//
//            } label: {
//                Label("Temperature", systemImage: "thermometer")
//            }.groupBoxStyle(TransparentGroupBox())
          //  Spacer(minLength: 1)
        }
        .padding([.bottom,.trailing,.leading])
        .padding(.top, 40)
        .fullscreenBackground(WeatherUtils.gradientMap[dayWeather.weather.first?.main ?? "N/A"] ?? WeatherUtils.clearGradient)
        .ignoresSafeArea()
    }
}



struct SummaryDayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryDayWeatherView(dayWeather: DayForecast.thunderstorm, city: "Chapel Hill").preferredColorScheme(.dark)
    }
}

struct SummaryFeelsLikeView: View {
    let dayWeather: DayForecast
    
    var body: some View {
        GroupBox {
            Divider()
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            let images: [Image] = [
                Image(systemName: "sunrise"),
                Image(systemName: "sun.max"),
                Image(systemName: "sunset"),
                Image(systemName: "moon")
            ]
            let texts: [Text] = [
                Text("Morn"),
                Text("Day"),
                Text("Eve"),
                Text("Night"),
                Text("\(dayWeather.feels_like.morn, specifier: "%.0f")°C"),
                Text("\(dayWeather.feels_like.day, specifier: "%.0f")°C"),
                Text("\(dayWeather.feels_like.eve, specifier: "%.0f")°C"),
                Text("\(dayWeather.feels_like.night, specifier: "%.0f")°C")
            ]
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<images.count, id: \.self) {
                    i in
                    images[i]
//                        .resizable().scaledToFit().frame(maxWidth:.infinity)
                        .font(.largeTitle)
                }
                // Cannot have repeating ids from other ForEachs
                ForEach(images.count..<texts.count+images.count, id: \.self) {
                    i in
                    texts[i-images.count]
                }
            }
            
//            HStack {
//                VStack(alignment:.leading) {
//                    Label("Morn: \(dayWeather.feels_like.morn, specifier: "%.2f")°C", systemImage: "sunrise")
//                    Label("Day: \(dayWeather.feels_like.day, specifier: "%.2f")°C", systemImage: "sun.max")
//                    Label("Eve: \(dayWeather.feels_like.eve, specifier: "%.2f")°C", systemImage: "sunset")
//                    Label("Night: \(dayWeather.feels_like.night, specifier: "%.2f")°C", systemImage: "moon")
//                }
//                Spacer()
//            }
        } label: {
            Label("Feels Like", systemImage: "person")
        }.groupBoxStyle(TransparentGroupBox())
    }
}

struct SummaryTemperatureView: View {
    let dayWeather: DayForecast
    
    var body: some View {
        GroupBox {
            Divider()
            
            
            HStack {
                VStack(alignment:.leading) {
                    Label("High: \(dayWeather.temp.max, specifier: "%.0f")°C", systemImage: "chevron.up")
                    Label("Low: \(dayWeather.temp.min, specifier: "%.0f")°C", systemImage: "chevron.down")
                }
                Spacer()
            }.font(.title3)
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            let images: [Image] = [
                Image(systemName: "sunrise"),
                Image(systemName: "sun.max"),
                Image(systemName: "sunset"),
                Image(systemName: "moon")
            ]
            let texts: [Text] = [
                Text("Morn"),
                Text("Day"),
                Text("Eve"),
                Text("Night"),
                Text("\(dayWeather.temp.morn, specifier: "%.0f")°C"),
                Text("\(dayWeather.temp.day, specifier: "%.0f")°C"),
                Text("\(dayWeather.temp.eve, specifier: "%.0f")°C"),
                Text("\(dayWeather.temp.night, specifier: "%.0f")°C")
            ]
            
            Divider()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<images.count, id: \.self) {
                    i in
                    images[i]
//                        .resizable().scaledToFit().frame(maxWidth:.infinity)
                        .font(.largeTitle)
                }
                // Cannot have repeating ids from other ForEachs
                ForEach(images.count..<texts.count+images.count, id: \.self) {
                    i in
                    texts[i-images.count]
                }
            }
            
//            HStack {
//                VStack(alignment:.leading) {
//                    Label("High: \(dayWeather.temp.max, specifier: "%.2f")°C", systemImage: "chevron.up")
//                    Label("Low: \(dayWeather.temp.min, specifier: "%.2f")°C", systemImage: "chevron.down")
//                    Label("Morn: \(dayWeather.temp.morn, specifier: "%.2f")°C", systemImage: "sunrise")
//                    Label("Day: \(dayWeather.temp.day, specifier: "%.2f")°C", systemImage: "sun.max")
//                    Label("Eve: \(dayWeather.temp.eve, specifier: "%.2f")°C", systemImage: "sunset")
//                    Label("Night: \(dayWeather.temp.night, specifier: "%.2f")°C", systemImage: "moon")
//                }
//                Spacer()
//            }
            
        } label: {
            Label("Temperature", systemImage: "thermometer")
        }.groupBoxStyle(TransparentGroupBox())
    }
}
