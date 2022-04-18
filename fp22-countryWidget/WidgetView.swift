//
//  WidgetView.swift
//  fp22-countryWidgetExtension
//
//  Created by Josh Myatt on 4/14/22.
//

import SwiftUI
import WidgetKit



struct WidgetView: View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallSizeView(entry: entry)
        case .systemLarge:
            LargeSizeView(entry: entry)
        default:
            Text("Not Implemented Here")
        }
    }
}

