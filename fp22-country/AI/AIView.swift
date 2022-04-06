//
//  AIView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/5/22.
//

import SwiftUI

struct AIView: View {
    
    @StateObject var vm = AIViewModel()
    
    init() {
        // https://stackoverflow.com/questions/62848276/change-background-color-of-texteditor-in-swiftui
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        Form {
            Section("Output") {
                ScrollView {
                    Text(vm.output).frame(minHeight:100)
                }
            }
            Section ("Input and Settings") {
                ScrollView {
                    TextEditor(text: $vm.text).overlay(alignment:.topLeading) {
                        Text("Start Typing").foregroundColor(.secondary).padding(.top, 8).padding(.leading, 5).opacity(vm.text.isEmpty ? 1 : 0)
                        
                    }.frame(minHeight:100)
                }
                Stepper(value: $vm.tokens, in: 25...250, step: 25) {
                    Text("Tokens: \(vm.tokens)")
                }
                Stepper(value: $vm.temp, in: 0...1.0, step: 0.1) {
                    Text("Temperature: \(vm.temp, specifier: "%.1f")")
                }
                Button {
                    vm.submit()
                } label: {
                    Label("Fetch", systemImage: "gearshape.2")
                }
            }
        }
    }
}

struct AIView_Previews: PreviewProvider {
    static var previews: some View {
        AIView()
            .preferredColorScheme(.dark)
    }
}
