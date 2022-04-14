//
//  ContentView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    let preview: Bool
    
    init(preview: Bool = false) {
        self.preview = preview
    }
    
    var body: some View {
        NavigationView {
            TabView {
                WeatherView(preview: preview).tabItem {
                    Label("Debugging Weather View", systemImage: "cloud")
                }
                AIView().tabItem {
                    Label("Debugging AI View", systemImage: "ladybug")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(preview: true).preferredColorScheme(.dark)
    }
}
