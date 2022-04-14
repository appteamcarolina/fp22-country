//
//  AIService.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

@available(*, deprecated, message: "Use AsyncAIService instead")
struct AIService {
    private static var delegate: ((AIResponse) -> Void)?
    
    public static func setDelegate(method: @escaping((AIResponse) -> Void)) {
        AIService.delegate = method
    }
    
    public static func test() {
        sendRequest(prompt: "What is AI", temp: 0.1, tokens: 150)
    }
    
    public static func sendRequest(prompt: String, temp: Double, tokens: Int) {
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
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard error == nil, let data = data else {return}
            
            print(String(decoding: data, as: UTF8.self))
            
            if let response = try? JSONDecoder().decode(AIResponse.self, from: data) {
                if let delegate = delegate {
                    delegate(response)
                }
                else {
                    print("No delegate assigned")
                }
            }
            else {
                print("Failed to decode incoming data")
            }
        }.resume()
    }
}


