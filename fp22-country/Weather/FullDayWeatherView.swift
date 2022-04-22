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
                
                
                TemperatureView(dayWeather: dayWeather)
                FeelsLikeView(dayWeather: dayWeather)
                SunMoonView(dayWeather: dayWeather)
                
                GroupBox {
                    Divider()
                    HStack(alignment:.top) {
                        VStack(alignment:.leading) {
                            Text("Wind Speed: \(dayWeather.wind_speed, specifier: "%.1f") m/s")
                            Text("Wind Deg: \(dayWeather.wind_deg)°")
                        }.scaledToFill()
                        NavigationLink {
                            CompassView(windHeading:Double(dayWeather.wind_deg))
                        } label: {
                            ZStack {
                                Circle().stroke(Color.black, lineWidth: 2).scaledToFit()
                                VStack{
                                    Image(systemName: "location.north").resizable().scaledToFit().foregroundColor(.red)
                                    Image(systemName: "location.north").resizable().scaledToFit().rotationEffect(Angle(degrees: 180)).foregroundColor(.white)
                                    
                                }.scaledToFit().rotationEffect(Angle(degrees: Double(dayWeather.wind_deg)))
                            }.aspectRatio(1, contentMode: .fit).contentShape(Rectangle())
                        }
                        
//                        Spacer()
                    }
                } label: {
                    Label("Wind Info", systemImage: "wind")
                }.groupBoxStyle(TransparentGroupBox())
                
                GroupBox {
                    Divider()
                    HStack {
                        VStack(alignment:.leading) {
                            Label("Pressure: \(dayWeather.pressure) hPa", systemImage: "barometer")
                            Label("Humidity: \(dayWeather.humidity)%", systemImage: "humidity")
//                            Label("Wind Speed: \(dayWeather.wind_speed, specifier: "%.1f") m/s", systemImage: "wind")
//                            Label("Wind Deg: \(dayWeather.humidity)°", systemImage: "wind")
                        }
                        Spacer()
                    }
                } label: {
                    Label("Other Info", systemImage: "info.circle")
                }.groupBoxStyle(TransparentGroupBox())
                
               
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
        NavigationView {
            FullDayWeatherView(dayWeather: DayForecast.drizzle).preferredColorScheme(.dark)
        }
    }
}

struct SunMoonView: View {
    let dayWeather: DayForecast
    
    var body: some View {
        GroupBox {
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            let images: [Image] = [
                Image(systemName: "sunrise"),
                Image(systemName: "sunset"),
                Image(systemName: "moon.fill"),
                Image(systemName: "moon")
            ]
            let texts: [Text] = [
                Text("Sunrise"),
                Text("Sunset"),
                Text("Moonrise"),
                Text("Moonset"),
                Text(WeatherUtils.formatUnixTime(dayWeather.sunset)),
                Text(WeatherUtils.formatUnixTime(dayWeather.sunrise)),
                Text(WeatherUtils.formatUnixTime(dayWeather.moonrise)),
                Text(WeatherUtils.formatUnixTime(dayWeather.moonset))
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
        } label: {
            Label("Sun and Moon", systemImage: "sun.and.horizon")
        }.groupBoxStyle(TransparentGroupBox())
    }
}

struct FeelsLikeView: View {
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
                Text("Morning"),
                Text("Day"),
                Text("Evening"),
                Text("Night"),
                Text("\(dayWeather.feels_like.morn, specifier: "%.2f")°C"),
                Text("\(dayWeather.feels_like.day, specifier: "%.2f")°C"),
                Text("\(dayWeather.feels_like.eve, specifier: "%.2f")°C"),
                Text("\(dayWeather.feels_like.night, specifier: "%.2f")°C")
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

struct TemperatureView: View {
    let dayWeather: DayForecast
    
    var body: some View {
        GroupBox {
            Divider()
            
            
            HStack {
                VStack(alignment:.leading) {
                    Label("High: \(dayWeather.temp.max, specifier: "%.2f")°C", systemImage: "chevron.up")
                    Label("Low: \(dayWeather.temp.min, specifier: "%.2f")°C", systemImage: "chevron.down")
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
                Text("Morning"),
                Text("Day"),
                Text("Evening"),
                Text("Night"),
                Text("\(dayWeather.temp.morn, specifier: "%.2f")°C"),
                Text("\(dayWeather.temp.day, specifier: "%.2f")°C"),
                Text("\(dayWeather.temp.eve, specifier: "%.2f")°C"),
                Text("\(dayWeather.temp.night, specifier: "%.2f")°C")
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
