//
//  WeatherViewModel.swift
//  WeatherApp
//

import Foundation
import Combine

/// A view model for managing current weather and hourly forecast data.
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var hourlyForecast: [ForecastResponse.Forecast] = []
    @Published var errorMessage: String?

    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    
    /// Computed property to generate the URL for the current weather icon.
    var iconURL: String? {
        guard let iconCode = currentWeather?.weather.first?.icon else { return nil }
        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
    }

    /// Fetches the current weather and hourly forecast for a specified city.
    /// - Parameter city: The name of the city for which the weather data is fetched.
    func fetchWeatherData(for city: String) {
        weatherService.fetchCurrentWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { weather in
                self.currentWeather = weather
            }
            .store(in: &cancellables)
        /// Fetch hourly forecast./
        weatherService.fetchForecast(for: city)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { forecastResponse in
                /// Update the hourly forecast data./
                self.hourlyForecast = forecastResponse.list
            }
            .store(in: &cancellables)
    }
}
