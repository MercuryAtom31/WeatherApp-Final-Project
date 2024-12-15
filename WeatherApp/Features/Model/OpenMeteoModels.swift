//
//  OpenMeteoModels.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation

struct OpenMeteoResponse: Decodable {
    let daily: OpenMeteoDaily
}

struct OpenMeteoDaily: Decodable {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let weathercode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature_2m_max
        case temperature_2m_min
        case weathercode
    }
}

struct OpenMeteoDailyForecastData: Identifiable {
    let id = UUID()
    let date: String
    let maxTemp: Double
    let minTemp: Double
    let weatherCode: Int
}

