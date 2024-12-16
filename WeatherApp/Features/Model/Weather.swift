//
//  Weather.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-04.

// Represents the current weather data.
//

import Foundation

/// Represents the current weather data.
struct Weather: Codable {
    let coord: Coordinates          /// Coordinates of the city
    let weather: [WeatherInfo]      /// Weather description and icon
    let main: Main                  /// Main weather data like temperature, pressure, etc.
    let wind: Wind                  /// Wind details
    let clouds: Clouds              /// Cloud percentage
    let dt: Int                     /// Time of the data calculation
    let sys: SystemInfo             /// Country, sunrise, and sunset info
    let timezone: Int               /// Timezone of the location
    let name: String                /// City name

    /// Represents geographic coordinates of the location.
    struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }

    /// Represents a single weather condition.
    struct WeatherInfo: Codable {
        let id: Int               /// Weather condition ID
        let main: String          /// Group of weather parameters (e.g., Rain, Clear)
        let description: String   /// Detailed weather description
        let icon: String          /// Icon ID for weather visualization
    }

    /// Contains main weather measurements.
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }

    /// Contains wind details.
    struct Wind: Codable {
        let speed: Double         /// Wind speed in meters/second
        let deg: Int              /// Wind direction in degrees
    }

    /// Represents cloud coverage.
    struct Clouds: Codable {
        let all: Int              /// Cloudiness percentage
    }

    /// Contains system-level information such as country and sunrise/sunset times.
    struct SystemInfo: Codable {
        let type: Int?
        let id: Int?
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}

