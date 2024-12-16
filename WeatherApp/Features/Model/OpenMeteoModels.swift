//
//  OpenMeteoModels.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation

/// Represents the top-level response from the OpenMeteo API.
struct OpenMeteoResponse: Decodable {
    let daily: OpenMeteoDaily
}

/// Represents daily weather data from the OpenMeteo API.
struct OpenMeteoDaily: Decodable {
    let time: [String]
    /// Maximum temperatures for the corresponding dates.
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let weathercode: [Int]
    
    /// Maps JSON keys to the struct properties.
    enum CodingKeys: String, CodingKey {
        case time
        case temperature_2m_max
        case temperature_2m_min
        case weathercode
    }
}

/// Represents a processed daily forecast for display purposes.
struct OpenMeteoDailyForecastData: Identifiable {
    let id = UUID()
    let date: String
    let maxTemp: Double
    let minTemp: Double
    let weatherCode: Int
}

