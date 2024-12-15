//
//  MapPinData.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import CoreLocation

struct MapPinData: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let temperature: String
    let minTemp: String
    let maxTemp: String
    let windSpeed: String
    let humidity: String

    // Implement Equatable manually
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
