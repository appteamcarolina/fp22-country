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
        SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), ai: "")
    }
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), ai: "")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
    
        let location = Location(city: WidgetWeatherStore.fetchCity(), country: WidgetWeatherStore.fetchCountry())
        let todayWeather = WidgetWeatherStore.fetchForecast()
        let entry = SimpleEntry(date: Date(), location: location, weather: todayWeather, ai: WidgetAIStore.fetchChoices())
        let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 60 * 30)))
        completion(timeline)
    }
    
    
    
    
    
    
    
}

