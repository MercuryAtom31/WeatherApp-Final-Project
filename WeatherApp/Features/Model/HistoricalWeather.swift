//
//  HistoricalWeather.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

struct LocalWeather: Codable {
    let location: CustomLocation
    let historical_weather: [HistoricalWeather]
}

struct CustomLocation: Codable {
    let city: String
    let latitude: Double
    let longitude: Double
}

struct HistoricalWeather: Identifiable, Codable {
    var id: UUID = UUID() // Generate a default UUID if not present in JSON
    let date: String
    let temperature: Temperature
    let condition: String
    let humidity: Int
    let wind_speed: Int
    let precipitation: Double

    // Custom CodingKeys to map JSON properties
    enum CodingKeys: String, CodingKey {
        case date, temperature, condition, humidity, wind_speed, precipitation
    }
    
    // Custom init to decode without requiring `id`
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.temperature = try container.decode(Temperature.self, forKey: .temperature)
        self.condition = try container.decode(String.self, forKey: .condition)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.wind_speed = try container.decode(Int.self, forKey: .wind_speed)
        self.precipitation = try container.decode(Double.self, forKey: .precipitation)
        self.id = UUID() // Assign a new UUID since it is not in the JSON
    }
    
    struct Temperature: Codable {
        let high: Int
        let low: Int
    }
}
