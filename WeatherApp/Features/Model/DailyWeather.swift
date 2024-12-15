//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-06.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    let id = UUID()
    let date: String          // Example: "Tuesday"
    let highTemp: Double      // High temperature
    let lowTemp: Double       // Low temperature
    let conditionIcon: String // SF Symbol name, e.g., "sun.max.fill"
}
