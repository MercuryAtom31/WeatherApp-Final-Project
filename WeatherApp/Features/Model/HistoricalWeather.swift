//
//  HistoricalWeather.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

/// Represents the overall weather data for a specific location.
struct LocalWeather: Codable {
    
    let location: CustomLocation
    
    /// A list of historical weather records for the location.
    let historical_weather: [HistoricalWeather]
}

/// Represents location details with city name and geographic coordinates.
struct CustomLocation: Codable {
    let city: String
    let latitude: Double
    let longitude: Double
}

/// Represents a single historical weather record.
struct HistoricalWeather: Identifiable, Codable {
    var id: UUID = UUID() /// Generate a default UUID if not present in JSON
    let date: String
    let temperature: Temperature
    let condition: String
    let humidity: Int
    let wind_speed: Int
    let precipitation: Double /// The precipitation amount in millimeters.

    /// Custom CodingKeys to map JSON properties
    enum CodingKeys: String, CodingKey {
        case date, temperature, condition, humidity, wind_speed, precipitation
    }
    
    /// Custom initializer to decode JSON while generating a unique ID.
    /// - Parameter decoder: The decoder used to decode JSON data.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.temperature = try container.decode(Temperature.self, forKey: .temperature)
        self.condition = try container.decode(String.self, forKey: .condition)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.wind_speed = try container.decode(Int.self, forKey: .wind_speed)
        self.precipitation = try container.decode(Double.self, forKey: .precipitation)
        self.id = UUID() /// Assign a new UUID since it is not in the JSON
    }
    
    /// Represents the temperature details with high and low values.
    struct Temperature: Codable {
        let high: Int
        let low: Int
    }
}
