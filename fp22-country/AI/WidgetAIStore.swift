//
//  WidgetAIStore.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/18/22.
//

import Foundation

struct WidgetAIStore {
    static func save(choices: String) -> Void{
        UserDefaults.standard.set(choices, forKey: "choices")
    }
    
    static func fetchChoices() -> String {
        UserDefaults.standard.string(forKey: "choices") ?? "Default"
    }
    
}
