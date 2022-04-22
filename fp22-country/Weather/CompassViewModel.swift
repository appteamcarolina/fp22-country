//
//  CompassViewModel.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/21/22.
//

import Foundation

class CompassViewModel: ObservableObject {
    @Published var compassHeading = 0.0
    var locationManager = AsyncLocationManager()
    
    init() {
    }
    
    func startTracking() {
        Task {
            let authStatus = await locationManager.requestAuthorization()
            let asyncStream = self.locationManager.requestHeadingStream()
            print("Start tracking")
            for await heading in asyncStream {
                print("Streamed")
                self.compassHeading = heading.magneticHeading
            }
        }
    }
    func stopTracking() {
        locationManager.stopHeadingStream()
    }
    
    deinit {
        locationManager.stopHeadingStream()
    }
}
