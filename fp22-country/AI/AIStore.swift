//
//  WidgetAIStore.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/18/22.
//

import Foundation
import WidgetKit

struct AIStore {
    static let userDefaults = UserDefaults(suiteName: "group.com.fp22-country.contents")!
    
    static func save(choices: String) -> Void{
        userDefaults.set(choices, forKey: "choices")
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    static func fetchChoices() -> String {
        userDefaults.string(forKey: "choices") ?? "Default"
    }
    
    static func saveSettings(tokens: Int, temp: Double) {
        userDefaults.set(tokens, forKey: "ai_tokens")
        userDefaults.set(temp, forKey: "ai_temp")
    }
    static func fetchTokens() -> Int {
        let token = userDefaults.integer(forKey: "ai_tokens")
        return token > 0 ? token : 50
    }
    static func fetchTemp() -> Double {
        let temp = userDefaults.double(forKey: "ai_temp")
        return temp > 0 ? temp: 0.1
    }
}
