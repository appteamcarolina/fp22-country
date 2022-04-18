//
//  SmallSizeView.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/14/22.
//

import SwiftUI


struct SmallSizeView: View {
    var entry: SimpleEntry
    var body: some View {
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date)
        VStack{
            Text("City")
            Text(entry.location.city)
            Text("Temp")
            if(hour >= 6 && hour < 12) {
                Text("\(Int(entry.weather.morn))")
            }
            else if(hour >= 12 && hour < 18){
                Text("\(Int(entry.weather.day))")
            }
            else if(hour >= 18 && hour < 21){
                Text("\(Int(entry.weather.eve))")
            }
            else if(hour >= 21 && hour < 6){
                Text("\(Int(entry.weather.night))")
            }
            Text("AI Suggestion")
            Text(entry.ai)
        }
    }
}

