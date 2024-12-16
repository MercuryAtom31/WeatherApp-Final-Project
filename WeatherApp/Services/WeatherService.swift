//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import Foundation
import Combine

/// A service class responsible for fetching weather data from the OpenWeather API.
class WeatherService {
    
    /// The API key for authenticating with the OpenWeather API.
    private let apiKey = "d09c183aa1ba49c6b4f588d714ac82c0"
    /// The base URL for all OpenWeather API requests.
    private let baseURL = "https://api.openweathermap.org/data/2.5/"

    /// Fetches the current weather for a given city.
    /// - Parameter city: The name of the city to fetch weather for.
    /// - Returns: A publisher that emits a `Weather` object or an error.
    func fetchCurrentWeather(for city: String) -> AnyPublisher<Weather, Error> {
        let urlString = "\(baseURL)weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            /// Return a failure publisher if the URL is invalid.
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        /// Perform the API request, decode the response into a Weather object, and return the result as a publisher.
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    /// Fetches the hourly and daily forecast for a given city.
    /// - Parameter city: The name of the city to fetch the forecast for.
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

    /// Perform the API request, decode the response into a ForecastResponse object, and return the result as a publisher.
    func fetchWeeklyForecast(for city: String) -> AnyPublisher<[ForecastResponse.Forecast], Error> {
        let urlString = "\(baseURL)forecast/daily?q=\(city)&cnt=7&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        /// Perform the API request, decode the response into a ForecastResponse object, extract the list property, and return the result as a publisher./
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .map { $0.list } // Use the correct property (e.g., `list`) for the weekly forecasts
            .eraseToAnyPublisher()
    }
}
