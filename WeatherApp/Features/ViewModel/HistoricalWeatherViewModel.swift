//
//  HistoricalWeatherViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI
import Foundation

/// ViewModel for managing historical weather data./
class HistoricalWeatherViewModel: ObservableObject {
    /// Published property holding the full historical weather dataset.
    @Published var historicalData: [HistoricalWeather] = []
    @Published var filteredData: [HistoricalWeather] = []
    @Published var filterCondition: String = ""
    @Published var sortOption: SortOption = .date

    /// Initializes the ViewModel and loads historical weather data from a local JSON file.
    init() {
        loadLocalWeather()
    }

    /// Loads historical weather data from a JSON file.
    private func loadLocalWeather() {
        guard let url = Bundle.main.url(forResource: "local_weather", withExtension: "json") else {
            print("Failed to locate local_weather.json")
            return
        }

        do {
            /// Decode the JSON data into a `LocalWeather` object./
            let data = try Data(contentsOf: url)
            let decodedWeather = try JSONDecoder().decode(LocalWeather.self, from: data)
            /// Store the historical weather data and apply initial filter and sort./
            self.historicalData = decodedWeather.historical_weather
            applyFilterAndSort()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    /// Applies filtering and sorting to the historical weather data.
    func applyFilterAndSort() {
        let filtered = filterCondition.isEmpty
            ? historicalData
            : historicalData.filter { weather in
                weather.condition.lowercased().contains(filterCondition.lowercased())
            }

        /// Sort the filtered data based on the selected sorting option.
        switch sortOption {
        case .date:
            filteredData = filtered.sorted { $0.date < $1.date }
        case .temperatureHigh:
            filteredData = filtered.sorted { $0.temperature.high > $1.temperature.high }
        case .temperatureLow:
            filteredData = filtered.sorted { $0.temperature.low < $1.temperature.low }
        case .windSpeed:
            filteredData = filtered.sorted { $0.wind_speed > $1.wind_speed }
        case .humidity:
            filteredData = filtered.sorted { $0.humidity > $1.humidity }
        }
    }

    /// Enumeration defining the available sorting options for historical weather data.
    enum SortOption {
        case date
        case temperatureHigh
        case temperatureLow
        case windSpeed
        case humidity
    }
}
