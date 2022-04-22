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
            let authStatus = await locationManager.requestWhenInUseAuthorization()
            let asyncStream = self.locationManager.requestHeadingStream()
            for await heading in asyncStream {
                DispatchQueue.main.async {
                    self.compassHeading = -1 * heading.magneticHeading
                }
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
