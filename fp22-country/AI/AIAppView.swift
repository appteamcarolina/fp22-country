//
//  AIAppView.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/21/22.
//

import SwiftUI

struct AIAppView: View {
    @StateObject var vm: AIAppViewModel = AIAppViewModel()
        
    init() {
        
    }
    init(dayWeather: DayForecast) {
        _vm = StateObject(wrappedValue: AIAppViewModel(dayWeather: dayWeather))
    }
    
    var body: some View {
        GroupBox{
            Divider()
            VStack(alignment:.leading){
                Text("Q: ").bold() + Text(vm.prompt)
                if (vm.received) {
                    Text("A: ").bold() + Text(vm.output)
                }
                else if (vm.inProgress) {
                    HStack {
                        Text("A: ").bold()
                        ProgressView()
                    }
                }
                Button {
                    vm.submit()
                } label: {
                    RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)).strokeBorder( lineWidth:2).overlay(alignment: .center) {
                        Label("Get suggestion", systemImage: "gear")
                    }
                    .contentShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    .frame(maxWidth: .infinity).frame(height: 40)
                }.buttonStyle(.plain)
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
