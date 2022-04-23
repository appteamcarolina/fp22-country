//
//  SettingsViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/22/22.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var tokens = AIStore.fetchTokens()
    @Published var temp = AIStore.fetchTemp()
    
    
    func save() {
        AIStore.saveSettings(tokens: tokens, temp: temp)
    }
}
