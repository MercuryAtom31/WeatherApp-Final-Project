//
//  WeatherViewModel.swift
//  WeatherApp
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var hourlyForecast: [ForecastResponse.Forecast] = []
    @Published var errorMessage: String?

    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    
    var iconURL: String? {
        guard let iconCode = currentWeather?.weather.first?.icon else { return nil }
        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
    }


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

        weatherService.fetchForecast(for: city)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { forecastResponse in
                self.hourlyForecast = forecastResponse.list
            }
            .store(in: &cancellables)
    }
}
