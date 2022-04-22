//
//  AIAppViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/22/22.
//

import Foundation
import SwiftUI

class AIAppViewModel: ObservableObject {
    @Published private(set) var output = ""
    @Published var tokens = AIStore.fetchTokens()
    @Published var temp = AIStore.fetchTemp()
    @Published var dayWeather: DayForecast
    
    @Published var prompt: String
    @Published var received: Bool = false
    @Published var inProgress: Bool = false
    
    init(dayWeather: DayForecast = .clear) {
        self.dayWeather = dayWeather
        self.prompt = "What should I wear when the weather is \(dayWeather.weather[0].description) and the temperature is \(String(format: "%.0f", dayWeather.temp.day)) celsius?"
    }
    
    
    func submit () {
//        AIService.sendRequest(prompt: text, temp: temp, tokens: tokens)
        received = false
        withAnimation {
            inProgress = true
        }
        Task {
            do {
                let response = try await AsyncAIService.requestAIResponse(prompt: prompt, temp: temp, tokens: tokens)
                
                
                
                DispatchQueue.main.async {
                    withAnimation {
                        self.output = response.choices[0].text.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.received = true
                        self.inProgress = false
                    }
                    if Calendar.current.isDate(.now, inSameDayAs:Date(timeIntervalSince1970: self.dayWeather.dt))  {
                        // Only store current date for widget
                        print("Today is \(Date(timeIntervalSince1970: self.dayWeather.dt).formatted(date: .abbreviated, time: .omitted))")
                        AIStore.save(choices: self.output)
                    }
                }
            }
            catch {
                self.inProgress = false
                print(error.localizedDescription)
            }
            
        }
    }
}
