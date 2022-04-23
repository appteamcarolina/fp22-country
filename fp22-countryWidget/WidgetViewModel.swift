//
//  WidgetViewModel.swift
//  fp22-countryWidgetExtension
//
//  Created by Josh Myatt on 4/19/22.
//

import Foundation
import SwiftUI


public class WidgetViewModel: ObservableObject {
    
    
    
    let aiToEmojiMap = [
        "jacket"  :"🧥",
        "coat"  :"🧥",
        "sweater"  :"🧥",
        "t-shirt" :"👕",
        "shorts"  :"🩳",
        "pants"   :"👖",
        "scarf"   :"🧣",
        "gloves"  :"🧤",
        "raincoat":"🌂",
        "umbrella":"🌂",
    ]
    
    
    
    
    func hourDetermine(entry: SimpleEntry) -> String {
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        if(hour >= 6 && hour < 12) {
            return "\(Int(entry.weather.morn))"
        }
        else if(hour >= 12 && hour < 18){
            return "\(Int(entry.weather.day))"
        }
        else if(hour >= 18 && hour < 21){
            return "\(Int(entry.weather.eve))"
        }
        else if(hour >= 21 && hour < 6){
            return "\(Int(entry.weather.night))"
        }
        else{
            return "\(Int(entry.weather.day))"
        }
        
    }
    
    // remove all punctuation chars from string and return an array of the sentence split up by words
    private func parseInput(entry: SimpleEntry) -> Array<String> {
        let inputString = entry.ai
        var stringWithout = inputString.replacingOccurrences(of: ".", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: ",", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: "!", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: "?", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: ":", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: ";", with: "")
        let returnArray = stringWithout.components(separatedBy: " ")
        return returnArray
    }
    
    
    // match AI output to clothing emojis
    func findEmojis(entry: SimpleEntry) -> String? {
        let searchArray = parseInput(entry: entry)
        var newEmoji: String? = ""
        for word in searchArray {
            newEmoji = aiToEmojiMap[word]
            if aiToEmojiMap[word] != nil {
                return newEmoji
            }
        }
        newEmoji = aiToEmojiMap[backUpWeather(entry: entry)]
        return newEmoji
        
    }
    // if AI produces a weird output, fill in with a base emoji that kinda makes sense
    private func backUpWeather(entry: SimpleEntry) -> String {
        if Int(hourDetermine(entry: entry)) ?? Int(entry.weather.day) < 15 {
            return "jacket"
        }
        else {
            return "t-shirt"
        }
    }
    
    func textDeterminer(entry: SimpleEntry) -> Color {
        if entry.sky.main == "Clouds" {
            return Color.black
        }
        else if entry.sky.main == "Snow" {
            return Color.black
        }
        else {
            return Color.white
        }
    }
    
    
    
    

    
    
}
