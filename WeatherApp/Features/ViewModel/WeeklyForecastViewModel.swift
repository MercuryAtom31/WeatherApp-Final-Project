//
//  WeeklyForecastViewModel.swift
//  WeatherApp
//

import Foundation
import Combine

class WeeklyForecastViewModel: ObservableObject {
    @Published var weeklyForecast: [ForecastResponse.Forecast] = []
    @Published var errorMessage: String?

    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()

    func fetchWeeklyForecast(for city: String) {
        weatherService.fetchWeeklyForecast(for: city)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Error fetching weekly forecast: \(error.localizedDescription)")
                }
            } receiveValue: { forecast in
                self.weeklyForecast = forecast
                print("Weekly forecast fetched: \(forecast)")
            }
            .store(in: &cancellables)
    }
}
