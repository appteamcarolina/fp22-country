//
//  SimpleEntry.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/13/22.
//

import Foundation
import WidgetKit


struct SimpleEntry: TimelineEntry {
    let date: Date
    let location: Location
    let weather: TempForecast
    let sky: WeatherForecast
    let ai: String
}


extension SimpleEntry {
    static func placeholder() -> SimpleEntry {
        SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), sky: .placeholder(), ai: "Test Test Test")
    }
}


