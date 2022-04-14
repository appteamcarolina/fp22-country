//
//  AsyncCoreLocation.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation
import CoreLocation


// https://www.hackingwithswift.com/quick-start/concurrency/how-to-store-continuations-to-be-resumed-later
//@MainActor
class AsyncLocationManager: NSObject, CLLocationManagerDelegate {
    var locationContinuation: CheckedContinuation<CLLocationCoordinate2D?, Error>?
    let manager = CLLocationManager()

    override init() {
//        print("init")
        super.init()
        manager.delegate = self
    }

    func requestLocation() async throws -> CLLocationCoordinate2D? {
//        print("request")
        return try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationContinuation?.resume(returning: locations.first?.coordinate)

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationContinuation?.resume(throwing: error)
    }
}
