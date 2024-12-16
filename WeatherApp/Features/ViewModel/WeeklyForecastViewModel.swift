//
//  WeeklyForecastViewModel.swift
//  WeatherApp
//

import Foundation
import Combine

/// A view model for managing and providing weekly forecast data to the UI.
class WeeklyForecastViewModel: ObservableObject {
    
    /// Published property holding the weekly forecast data.
    @Published var weeklyForecast: [ForecastResponse.Forecast] = []
    
    /// Published property to store error messages, if any, during data fetching.
    @Published var errorMessage: String?

    /// Instance of `WeatherService` to handle API calls.
    private let weatherService = WeatherService()
    
    /// A set of cancellables to manage Combine subscriptions and prevent memory leaks.
    private var cancellables = Set<AnyCancellable>()

    /// Fetches the weekly weather forecast for a specified city.
    /// - Parameter city: The name of the city for which the weekly forecast is fetched.
    func fetchWeeklyForecast(for city: String) {
        weatherService.fetchWeeklyForecast(for: city)
        /// Ensure updates are received on the main thread for UI updates.
            .receive(on: DispatchQueue.main)
            .sink { completion in
                /// Handle errors in the Combine pipeline/
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Error fetching weekly forecast: \(error.localizedDescription)")
                }
            } receiveValue: { forecast in
                /// Update the published property with the fetched forecast data.
                self.weeklyForecast = forecast
                print("Weekly forecast fetched: \(forecast)")
            }
            /// Store the subscription in the cancellables set to manage its lifecycle.
            .store(in: &cancellables)
    }
}
