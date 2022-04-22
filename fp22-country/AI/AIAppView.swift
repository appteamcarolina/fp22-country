//
//  AIAppView.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/21/22.
//

import SwiftUI

struct AIAppView: View {
    @StateObject var vm: AIViewModel = AIViewModel()
    var body: some View {
        GroupBox{
            Divider()
            HStack{
                Text("A light jacket, boots, a scarf, or sweater")
                    .font(.title2)
            }
        }
    label: {
        Label("AI Suggestion", systemImage: "brain.head.profile")
        }.groupBoxStyle(TransparentGroupBox())
    }
}

//label: {
//Label("Feels Like", systemImage: "person")
//}
//
///
    

struct AIAppView_Previews: PreviewProvider {
    static var previews: some View {
        AIAppView()
    }
}
