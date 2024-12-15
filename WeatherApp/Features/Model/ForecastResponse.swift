//
//  ForecastResponse.swift
//  WeatherApp
//

import Foundation

struct ForecastResponse: Decodable {
    let list: [Forecast]

    struct Forecast: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
    }

    struct Main: Decodable {
        let temp: Double
    }

    struct Weather: Decodable {
        let description: String
        let icon: String
    }
}
