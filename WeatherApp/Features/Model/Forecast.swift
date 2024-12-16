//
//  Forecast.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-04.
//

import Foundation

struct Forecast: Codable {
    let date: String
    let highTemperature: Double
    let lowTemperature: Double
    /// A short description of the weather condition (e.g., "Sunny", "Cloudy").
    let condition: String
}
