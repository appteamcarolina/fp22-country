//
//  WidgetAIStore.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/18/22.
//

import Foundation

struct WidgetAIStore {
    static let userDefaults = UserDefaults(suiteName: "group.com.fp22-country.contents")!
    
    static func save(choices: String) -> Void{
        userDefaults.set(choices, forKey: "choices")
    }
    
    static func fetchChoices() -> String {
        userDefaults.string(forKey: "choices") ?? "Default"
    }
    
}
