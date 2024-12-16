//
//  OpenMeteoService.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation

/// A service class for fetching daily weather data from the OpenMeteo API.
class OpenMeteoService {
    
    /// Fetches daily weather forecast data from the given URL.
    /// - Parameters:
    ///   - urlString: The URL string for the OpenMeteo API endpoint.
    ///   - completion: A closure that returns a `Result` containing an array of `OpenMeteoDailyForecastData` on success or an `Error` on failure.
    func fetchDailyData(urlString: String, completion: @escaping (Result<[OpenMeteoDailyForecastData], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        /// Perform the network request./
        URLSession.shared.dataTask(with: url) { data, response, error in
            /// Handle network errors./
            if let error = error {
                completion(.failure(error))
                return
            }
            /// Handle missing or invalid server responses./
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                /// Decode the JSON response into an `OpenMeteoResponse` object./
                let decoder = JSONDecoder()
                let result = try decoder.decode(OpenMeteoResponse.self, from: data)
                
                /// Map the response data to an array of `OpenMeteoDailyForecastData`.
                var forecasts: [OpenMeteoDailyForecastData] = []
                for i in 0..<result.daily.time.count {
                    let forecast = OpenMeteoDailyForecastData(
                        date: result.daily.time[i],
                        maxTemp: result.daily.temperature_2m_max[i],
                        minTemp: result.daily.temperature_2m_min[i],
                        weatherCode: result.daily.weathercode[i]
                    )
                    forecasts.append(forecast)
                }
                completion(.success(forecasts))
            } catch {
                /// Handle JSON decoding errors.
                completion(.failure(error))
            }
        }.resume()
    }
}
