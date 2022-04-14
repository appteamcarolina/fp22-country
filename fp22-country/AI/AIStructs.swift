//
//  AIStructs.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation

struct AIResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choices]
}
struct Choices: Decodable {
    let text: String
}

extension Choices {
    static func placeholder() -> Choices {
        Choices(text: "Wear shorts")
    }
}
