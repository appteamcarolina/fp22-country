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
    
    private(set) var authStatus: CLAuthorizationStatus
    private var authContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
    
    private var locationContinuation: CheckedContinuation<CLLocation?, Error>?
    private var locationStreamContinuation: AsyncStream<CLLocation?>.Continuation?
    private var headingStreamContinuation: AsyncStream<CLHeading>.Continuation?
    
    private let manager = CLLocationManager()

    override init() {
        authStatus = manager.authorizationStatus
        manager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()
        manager.delegate = self
    }
    func requestWhenInUseAuthorization() async -> CLAuthorizationStatus {
        if manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            return manager.authorizationStatus
        }
        else {
            manager.requestWhenInUseAuthorization()
            return await withCheckedContinuation { continuation in
                self.authContinuation = continuation
            }
        }
    }
    
    // Location async request
    func requestLocation() async throws -> CLLocation? {
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            self.manager.requestLocation()
        }
    }
    
    // Location AsyncStream
    func requestLocationStream() -> AsyncStream<CLLocation?> {
        let locations = AsyncStream(CLLocation?.self) { continuation in
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
            self.headingStreamContinuation = continuation
            self.startHeadingStream()
        }
        return locations
    }
    func startHeadingStream() {
        manager.startUpdatingHeading()
    }
    func stopHeadingStream() {
        headingStreamContinuation?.finish()
        headingStreamContinuation = nil
        manager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        print("Heading")
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
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authStatus = manager.authorizationStatus
        authContinuation?.resume(returning: authStatus)
        authContinuation = nil
    }
}
