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
        SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), ai: .placeholder())
    }
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), ai: .placeholder())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        let vm = WeatherViewModel()
        let location = Location(city: vm.city, country: vm.country)
        let todayWeather = vm.dailyForecasts[0]
        let aiVm = AIViewModel()
        let entry = SimpleEntry(date: Date(), location: location, weather: todayWeather.temp, ai: Choices(text: aiVm.output))
        let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60 * 60 * 30)))
        completion(timeline)
    }
    
    
    
    
    
    
    
}

