//
//  ContentView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            WeatherView().tabItem {
                Label("Weather", systemImage: "cloud")
            }
            AIView().tabItem {
                Label("Debugging AI tool", systemImage: "ladybug")
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
