//
//  HistoricalWeatherView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI

/// A SwiftUI view for displaying and managing historical weather data with filtering and sorting options.
struct HistoricalWeatherView: View {
    
    /// The view model that manages historical weather data and handles filtering and sorting.
    @StateObject private var viewModel = HistoricalWeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                /// Filtering Input
                TextField("Filter by Condition (e.g., Rainy, Sunny)", text: $viewModel.filterCondition)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: viewModel.filterCondition) { _ in
                        viewModel.applyFilterAndSort()
                    }
                
                /// Sorting Picker
                Picker("Sort by", selection: $viewModel.sortOption) {
                    Text("Date").tag(HistoricalWeatherViewModel.SortOption.date)
                    Text("High Temp").tag(HistoricalWeatherViewModel.SortOption.temperatureHigh)
                    Text("Low Temp").tag(HistoricalWeatherViewModel.SortOption.temperatureLow)
                    Text("Wind Speed").tag(HistoricalWeatherViewModel.SortOption.windSpeed)
                    Text("Humidity").tag(HistoricalWeatherViewModel.SortOption.humidity)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: viewModel.sortOption) { _ in
                    viewModel.applyFilterAndSort()
                }
                
                /// List Display
                List(viewModel.filteredData) { weather in
                    VStack(alignment: .leading) {
                        Text("Date: \(weather.date)")
                            .font(.headline)
                        HStack {
                            Text("High: \(weather.temperature.high)°C")
                            Text("Low: \(weather.temperature.low)°C")
                        }
                        .font(.subheadline)
                        Text("Condition: \(weather.condition)")
                        Text("Humidity: \(weather.humidity)% | Wind: \(weather.wind_speed) km/h")
                            .font(.footnote)
                    }
                    .padding(5)
                }
            }
            .navigationTitle("Historical Weather")
        }
    }
}
