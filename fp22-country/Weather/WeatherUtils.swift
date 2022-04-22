//
//  WeatherUtils.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation
import SwiftUI

public struct WeatherUtils {
    static let emojiMap = [
        "Drizzle" : "🌧",
        "Thunderstorm": "⛈",
        "Rain": "🌧",
        "Snow": "❄️",
        "Clear": "☀️",
        "Clouds" : "☁️"
    ]
    static let systemImageMap = [
        "Drizzle" : "cloud.drizzle",
        "Thunderstorm": "cloud.bolt.rain",
        "Rain": "cloud.rain",
        "Snow": "cloud.snow",
        "Clear": "sun.max",
        "Clouds" : "cloud"
    ]
    static let gradientMap = [
        "Drizzle" : drizzleGradient,
        "Thunderstorm": thunderstormGradient,
        "Rain": rainGradient,
        "Snow": snowGradient,
        "Clear": clearGradient,
        "Clouds" : cloudGradient
    ]
    
    
    static var cloudGradient: LinearGradient {
        LinearGradient(colors: [.gray, .white, .blue],
                       startPoint: .top,
                       endPoint: .bottom)

    }
    static var clearGradient: LinearGradient {
        LinearGradient(colors: [.cyan, .blue],
                       startPoint: .top,
                       endPoint: .bottom)
    }
    static var snowGradient: LinearGradient {
        LinearGradient(colors: [.white, .teal, .blue],
                       startPoint: .top,
                       endPoint: .bottom)
            

    }
    static var rainGradient: LinearGradient {
        LinearGradient(colors: [.gray, .blue],
                       startPoint: .top,
                       endPoint: .bottom)
            
    }
    static var thunderstormGradient: LinearGradient {
        LinearGradient(colors: [.black, .blue],
                       startPoint: .top,
                       endPoint: .bottom)
        

    }
    static var drizzleGradient: LinearGradient {
        LinearGradient(colors: [.gray, .teal, .blue],
                       startPoint: .top,
                       endPoint: .bottom)
            

    }
    static func formatUnixWeekDayAndDate (_ time: Double) -> String {
        return format(Date(timeIntervalSince1970: time), format: "EEEE M/d")
    }
    static func formatUnixWeekDay (_ time: Double) -> String {
        return format(Date(timeIntervalSince1970: time), format: "EEEE")
    }
    static func formatUnixDate(_ time: Double) -> String {
        return format(Date(timeIntervalSince1970: time), format: "M/d")
    }
    static func formatUnixTime(_ time: Double) -> String {
        return format(Date(timeIntervalSince1970: time), format: "hh:mm a")
    }
    static func format(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    // https://stackoverflow.com/questions/50712354/converting-utc-date-time-to-local-date-time-in-ios
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: date)
    }
    static func formatTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}

struct TransparentGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.content
        }
        .padding([.trailing, .leading, .bottom])
        .padding(.top, 50)
        .background(RoundedRectangle(cornerRadius: 8).fill(.ultraThinMaterial))
        .overlay(configuration.label.padding([.leading, .top], 15).font(.headline), alignment: .topLeading)
    }
}
