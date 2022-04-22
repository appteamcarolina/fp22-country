//
//  SettingsView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/22/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vm = SettingsViewModel()
    
    var body: some View {
        Form {
            Section ("AI Settings") {
                Stepper(value: $vm.tokens, in: 25...250, step: 25) {
                    Text("Tokens: \(vm.tokens)")
                }
                Stepper(value: $vm.temp, in: 0...1.0, step: 0.1) {
                    Text("Temperature: \(vm.temp, specifier: "%.1f")")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement:.navigationBarTrailing) {
                Button {
                    vm.save()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView().preferredColorScheme(.dark)
        }
    }
}
