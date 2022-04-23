//
//  Provider.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/13/22.
//

import Foundation
import WidgetKit


struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), sky: .placeholder(), ai: "You should wear a light jacket or sweater")
    }
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), sky: .placeholder(), ai: "You should wear a light jacket or sweater")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
    
        let location = Location(city: WeatherStore.fetchCity(), country: WeatherStore.fetchCountry())
        let todayWeather = WeatherStore.fetchForecast()
        let sky = WeatherStore.fetchSky()
        let entry = SimpleEntry(date: Date(), location: location, weather: todayWeather, sky: sky, ai: AIStore.fetchChoices())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
    
    
    
    
    
    
    
}

