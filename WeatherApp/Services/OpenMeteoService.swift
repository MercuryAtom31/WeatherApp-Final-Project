//
//  OpenMeteoService.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation

class OpenMeteoService {
    func fetchDailyData(urlString: String, completion: @escaping (Result<[OpenMeteoDailyForecastData], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(OpenMeteoResponse.self, from: data)
                
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
                completion(.failure(error))
            }
        }.resume()
    }
}
