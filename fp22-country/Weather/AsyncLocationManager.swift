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
    private var locationContinuation: CheckedContinuation<CLLocation?, Error>?
    private var locationStreamContinuation: AsyncStream<CLLocation?>.Continuation?
    private var headingStreamContinuation: AsyncStream<CLHeading>.Continuation?
    
    let manager = CLLocationManager()

    override init() {
//        print("init")
        super.init()
        manager.delegate = self
    }
    // Location async request
    func requestLocation() async throws -> CLLocation? {
//        print("request")
        return try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
    }
    
    // Location AsyncStream
    func requestLocationStream() -> AsyncStream<CLLocation?> {
        let locations = AsyncStream(CLLocation?.self) { continuation in
            manager.requestWhenInUseAuthorization()
            self.locationStreamContinuation = continuation
            self.startLocationStream()
        }
        return locations
    }
    func startLocationStream() {
        manager.startUpdatingLocation()
    }
    func stopLocationStream() {
        locationStreamContinuation?.finish()
        locationStreamContinuation = nil
        manager.stopUpdatingLocation()
    }
    // Heading AsyncStream
    func requestHeadingStream() -> AsyncStream<CLHeading> {
        let locations = AsyncStream(CLHeading.self) { continuation in
            manager.requestWhenInUseAuthorization()
            print("\(CLLocationManager.headingAvailable())")
            self.headingStreamContinuation = continuation
            self.startHeadingStream()
        }
        return locations
    }
    func startHeadingStream() {
//        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    func stopHeadingStream() {
        headingStreamContinuation?.finish()
        headingStreamContinuation = nil
//        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("Heading")
        headingStreamContinuation?.yield(newHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationContinuation?.resume(returning: locations.first)
        locationContinuation = nil
        
        locationStreamContinuation?.yield(locations.first)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
}
