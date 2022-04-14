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
    

    func submit () {
//        AIService.sendRequest(prompt: text, temp: temp, tokens: tokens)
        Task {
            do {
                let response = try await AsyncAIService.requestAIResponse(prompt: text, temp: temp, tokens: tokens)
                
                DispatchQueue.main.async {
                    self.output = response.choices[0].text
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
    }
}
