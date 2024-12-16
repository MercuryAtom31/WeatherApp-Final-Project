//
//  DailyForecastViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation

/// ViewModel for managing daily weather forecast data.
class DailyForecastViewModel: ObservableObject {
    
    /// Published property holding the daily weather forecasts.
    @Published var dailyForecasts: [OpenMeteoDailyForecastData] = []
    @Published var errorMessage: String?

    private let service = OpenMeteoService()
    
    /// Fetches the daily weather forecast for a specified location.
    /// - Parameters:
    ///   - lat: The latitude of the location.
    ///   - lon: The longitude of the location.
    func fetchDailyForecast(lat: Double, lon: Double) {
        
        /// Construct the API URL with location and desired parameters.
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=America%2FToronto"
        
        /// Use the service to fetch daily forecast data.
        service.fetchDailyData(urlString: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dailyData):
                    /// Update the published property with the fetched data./
                    self.dailyForecasts = dailyData
                case .failure(let error):
                    /// Capture and display error messages in case of failure.
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

