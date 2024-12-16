//
//  MapPinData.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import CoreLocation

/// Represents data for a map pin, including location and weather information.
struct MapPinData: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let temperature: String
    let minTemp: String
    let maxTemp: String
    let windSpeed: String
    let humidity: String

    /// Implements equality check for two `MapPinData` instances.
    /// - Parameters:
    /// - lhs: The left-hand side `MapPinData` instance.
    /// - rhs: The right-hand side `MapPinData` instance.
    /// - Returns: A Boolean value indicating whether the two instances are equal.
    static func == (lhs: MapPinData, rhs: MapPinData) -> Bool {
        return lhs.id == rhs.id &&
               lhs.coordinate.latitude == rhs.coordinate.latitude &&
               lhs.coordinate.longitude == rhs.coordinate.longitude &&
               lhs.temperature == rhs.temperature &&
               lhs.minTemp == rhs.minTemp &&
               lhs.maxTemp == rhs.maxTemp &&
               lhs.windSpeed == rhs.windSpeed &&
               lhs.humidity == rhs.humidity
    }
}
