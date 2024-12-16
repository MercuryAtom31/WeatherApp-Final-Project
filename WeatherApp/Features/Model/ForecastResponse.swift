//
//  ForecastResponse.swift
//  WeatherApp
//

import Foundation

/// Represents the response structure for weather forecast data from the API.
struct ForecastResponse: Decodable {
    
    /// A list of forecast details provided by the API.
    let list: [Forecast]

    /// Represents a single forecast entry in the API response.
    struct Forecast: Decodable {
        let dt: Int
        let main: Main
        /// An array of weather conditions for the forecast period.
        let weather: [Weather]
    }

    /// Represents the main temperature data for a specific forecast.
    struct Main: Decodable {
        let temp: Double
    }

    /// Represents the weather condition details for a specific forecast.
    struct Weather: Decodable {
        let description: String
        let icon: String
    }
}
