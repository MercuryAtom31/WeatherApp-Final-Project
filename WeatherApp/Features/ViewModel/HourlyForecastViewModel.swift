//
//  HourlyForecastViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import Foundation
import Combine

/// ViewModel responsible for managing hourly weather forecast data.
class HourlyForecastViewModel: ObservableObject {
    
    /// Published property holding a list of hourly weather forecasts.
    @Published var hourlyForecast: [ForecastResponse.Forecast] = []
    @Published var errorMessage: String = ""

    private let weatherService = WeatherService()
    /// A set of cancellables to manage Combine subscriptions and prevent memory leaks.
    private var cancellables = Set<AnyCancellable>()

    /// Fetches hourly weather forecasts for a specified city.
    /// - Parameter city: The name of the city for which the hourly forecast is fetched.
    func fetchHourlyForecast(for city: String) {
        weatherService.fetchForecast(for: city) /// Use the fetchForecast method
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { response in
                    /// Process and store the hourly forecasts for the next 24 hours.
                    self.hourlyForecast = self.extractHourlyForecasts(from: response.list)
                }
            )
            .store(in: &cancellables)
    }

    /// Filters and extracts hourly forecasts for the next 24 hours from the full forecast data.
    /// - Parameter forecasts: A list of forecasts from the API response.
    /// - Returns: A list of forecasts limited to the next 24 hours.
    private func extractHourlyForecasts(from forecasts: [ForecastResponse.Forecast]) -> [ForecastResponse.Forecast] {
        let calendar = Calendar.current
        let now = Date()
        
        /// Filter forecasts for the next 24 hours
        let filteredForecasts = forecasts.filter { forecast in
            let forecastDate = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
            return forecastDate > now && forecastDate < calendar.date(byAdding: .hour, value: 24, to: now)!
        }
        return filteredForecasts
    }
}

