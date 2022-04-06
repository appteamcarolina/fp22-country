//
//  WeatherReponse.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import Foundation

public struct Weather {
    let response: WeeklyForecastResponse
    
    init (response: WeeklyForecastResponse) {
        self.response = response
    }
}
