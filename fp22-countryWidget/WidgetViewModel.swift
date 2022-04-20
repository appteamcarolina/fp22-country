//
//  WidgetViewModel.swift
//  fp22-countryWidgetExtension
//
//  Created by Josh Myatt on 4/19/22.
//

import Foundation


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
        let testString = "A jacket."
        var stringWithout = testString.replacingOccurrences(of: ".", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: ",", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: "!", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: "?", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: ":", with: "")
        stringWithout = stringWithout.replacingOccurrences(of: ";", with: "")
        let returnArray = stringWithout.components(separatedBy: " ")
        return returnArray
    }
    
    
    // match AI output to clothing emojis
    func findEmojis(entry: SimpleEntry) -> Array<String?> {
        let searchArray = parseInput(entry: entry)
        var returnArray: Array<String?> = []
        for word in searchArray {
            let newEmoji: String? = aiToEmojiMap[word]
            if aiToEmojiMap[word] != nil {
                returnArray.append(newEmoji)
            }
        }
        if returnArray.count < 1 {
            let newEmoji: String? = aiToEmojiMap[backUpWeather(entry: entry)]
            if !returnArray.contains(newEmoji) {
                returnArray.append(newEmoji)
            }
        }
        return returnArray
    }
    // if AI produces a weird output, fill in with a base emoji that kinda makes sense
    private func backUpWeather(entry: SimpleEntry) -> String {
        if Int(hourDetermine(entry: entry)) ?? Int(entry.weather.day) < 60 {
            return "jacket"
        }
        else {
            return "t-shirt"
        }
    }
    
    
    
    

    
    
}
