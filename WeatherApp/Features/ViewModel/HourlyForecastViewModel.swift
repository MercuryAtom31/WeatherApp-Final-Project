//
//  HourlyForecastViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import Foundation
import Combine

class HourlyForecastViewModel: ObservableObject {
    @Published var hourlyForecast: [ForecastResponse.Forecast] = []
    @Published var errorMessage: String = ""

    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()

    func fetchHourlyForecast(for city: String) {
        weatherService.fetchForecast(for: city) // Use the fetchForecast method
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { response in
                    // Extract hourly forecasts (e.g., for the next 24 hours)
                    self.hourlyForecast = self.extractHourlyForecasts(from: response.list)
                }
            )
            .store(in: &cancellables)
    }

    // Helper method to extract hourly forecasts
    private func extractHourlyForecasts(from forecasts: [ForecastResponse.Forecast]) -> [ForecastResponse.Forecast] {
        let calendar = Calendar.current
        let now = Date()
        
        // Filter forecasts for the next 24 hours
        let filteredForecasts = forecasts.filter { forecast in
            let forecastDate = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
            return forecastDate > now && forecastDate < calendar.date(byAdding: .hour, value: 24, to: now)!
        }
        return filteredForecasts
    }
}

