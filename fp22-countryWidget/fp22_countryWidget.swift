//
//  fp22_countryWidget.swift
//  fp22-countryWidget
//
//  Created by Josh Myatt on 4/11/22.
//

import WidgetKit
import SwiftUI

@main
struct fp22_countryWidget: Widget {
    let kind: String = "fp22_countryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemLarge])
        .configurationDisplayName("fp22-country")
        .description("See what you should wear for the day")
    }
}

struct fp22_countryWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(entry: SimpleEntry(date: Date(), location: .placeHolder(), weather: .placeholder(), ai: .placeholder()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
 
