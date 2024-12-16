//
//  Location.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-04.
//

import Foundation

/// Represents a geographic location with a name and coordinates.
struct Location: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}
