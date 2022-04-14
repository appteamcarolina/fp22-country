//
//  AsyncAIService.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

struct AsyncAIService {
    public static func test() {
//        sendRequest(prompt: "What is AI", temp: 0.1, tokens: 150)
    }
    
    public static func requestAIResponse(prompt: String, temp: Double, tokens: Int) async throws -> AIResponse {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openai.com"
        components.path = "/v1/engines/text-davinci-002/completions"

        let params: [String : Any] = ["prompt": prompt, "temperature": temp, "max_tokens": tokens]
        
        var request = URLRequest(url: components.url!)
        request.setValue("Bearer \(Keys.OPENAI_API_KEY)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Status code not 200") }
        let decodedData = try JSONDecoder().decode(AIResponse.self, from: data)
        
        return decodedData
    }
}


