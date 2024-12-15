//
//  Weather.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-04.

// Represents the current weather data.
//

import Foundation

struct Weather: Codable {
    let coord: Coordinates          // Coordinates of the city
    let weather: [WeatherInfo]      // Weather description and icon
    let main: Main                  // Main weather data like temperature, pressure, etc.
    let wind: Wind                  // Wind details
    let clouds: Clouds              // Cloud percentage
    let dt: Int                     // Time of the data calculation
    let sys: SystemInfo             // Country, sunrise, and sunset info
    let timezone: Int               // Timezone of the location
    let name: String                // City name

    struct Coordinates: Codable {
        let lon: Double
        let lat: Double
    }

    struct WeatherInfo: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }

    struct Clouds: Codable {
        let all: Int
    }

    struct SystemInfo: Codable {
        let type: Int?
        let id: Int?
        let country: String
        let sunrise: Int
        let sunset: Int
    }
}

