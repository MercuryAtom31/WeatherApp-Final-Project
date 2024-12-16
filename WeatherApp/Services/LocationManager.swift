//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation
import CoreLocation

/// A class for managing location services using CoreLocation.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    /// An instance of `CLLocationManager` to handle location-related tasks.
    private let manager = CLLocationManager()
    /// Publishes the user's current location, allowing SwiftUI views to observe changes.
    @Published var location: CLLocation?

    /// Initializes the `LocationManager` and sets up location settings and permissions.
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }

    /// Requests a one-time location update.
    func requestLocation() {
        manager.requestLocation()
    }

    /// Delegate method called when the location manager updates the location.
    /// - Parameters:
    ///   - manager: The `CLLocationManager` instance managing location updates.
    ///   - locations: An array of updated `CLLocation` objects.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }

    /// Delegate method called when the location manager encounters an error.
    /// - Parameters:
    ///   - manager: The `CLLocationManager` instance managing location updates.
    ///   - error: The encountered error.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Log the error for debugging purposes.
        print("Location error: \(error.localizedDescription)")
    }
}
