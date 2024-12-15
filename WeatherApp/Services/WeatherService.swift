//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import Foundation
import Combine

class WeatherService {
    private let apiKey = "d09c183aa1ba49c6b4f588d714ac82c0"
    private let baseURL = "https://api.openweathermap.org/data/2.5/"

    // Fetch current weather
    func fetchCurrentWeather(for city: String) -> AnyPublisher<Weather, Error> {
        let urlString = "\(baseURL)weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    // Fetch hourly and daily forecasts
    func fetchForecast(for city: String) -> AnyPublisher<ForecastResponse, Error> {
        let urlString = "\(baseURL)forecast?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    // Fetch weekly forecast
    func fetchWeeklyForecast(for city: String) -> AnyPublisher<[ForecastResponse.Forecast], Error> {
        let urlString = "\(baseURL)forecast/daily?q=\(city)&cnt=7&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .map { $0.list } // Use the correct property (e.g., `list`) for the weekly forecasts
            .eraseToAnyPublisher()
    }
}
