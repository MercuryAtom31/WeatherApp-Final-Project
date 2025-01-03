//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-06.
//

import Foundation

/// Represents hourly weather data for display in the app.
struct HourlyWeather: Codable, Identifiable {
    let id = UUID()
    let time: String    /// Example: "2 PM"
    let temperature: Double
    let conditionIcon: String /// SF Symbol name, e.g., "cloud.sun.fill"
}
