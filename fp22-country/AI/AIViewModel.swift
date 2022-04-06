//
//  AIViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

class AIViewModel: ObservableObject {
    @Published var text = ""
    @Published var output = ""
    @Published var tokens = 50
    @Published var temp = 0.0
    
    init() {
        AIService.setDelegate(method: response)
    }
    func response (response: AIResponse) {
        DispatchQueue.main.async {
            self.output = response.choices[0].text
        }
    }
    func submit () {
        AIService.sendRequest(prompt: text, temp: temp, tokens: tokens)
    }
}
