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
    let condition: String
}
