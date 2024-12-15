//
//  MainWeatherView.swift
//  WeatherApp
//

import SwiftUI

struct MainWeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var hourlyViewModel = HourlyForecastViewModel()
    @StateObject private var dailyViewModel = DailyForecastViewModel()
    @State private var showMap = false // Controls the map sheet display

    var body: some View {
        ZStack {
            backgroundGradient(for: viewModel.currentWeather?.weather.first?.description)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    // Current Weather Section
                    if let weather = viewModel.currentWeather {
                        CurrentWeatherView(
                            temperature: String(format: "%.1f°C", weather.main.temp),
                            condition: weather.weather.first?.description.capitalized ?? "",
                            location: weather.name,
                            iconURL: viewModel.iconURL
                        )
                    } else {
                        ProgressView("Loading Current Weather...")
                            .foregroundColor(.white)
                    }

                    // Hourly Forecast Section
                    if !hourlyViewModel.hourlyForecast.isEmpty {
                        HourlyForecastView(hourlyForecast: hourlyViewModel.hourlyForecast)
                    }

                    // Daily Forecast Section
                    if !dailyViewModel.dailyForecasts.isEmpty {
                        DailyForecastView(dailyForecasts: dailyViewModel.dailyForecasts)
                    } else {
                        ProgressView("Loading Daily Forecast...")
                            .foregroundColor(.white)
                    }

                    // View Map Button
                    Button(action: {
                        showMap = true
                    }) {
                        Text("View Map")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showMap) {
            WeatherMapView(locationName: viewModel.currentWeather?.name ?? "Unknown")
        }
        .onAppear {
            viewModel.fetchWeatherData(for: "Montreal")
            hourlyViewModel.fetchHourlyForecast(for: "Montreal")
            dailyViewModel.fetchDailyForecast(lat: 45.5088, lon: -73.5878)
        }
    }

    private func backgroundGradient(for condition: String?) -> some View {
        let colors: [Color]
        switch condition?.lowercased() {
        case "clear sky":
            colors = [Color.blue.opacity(0.7), Color.orange]
        case "overcast clouds":
            colors = [Color.gray, Color.black.opacity(0.8)]
        case "rain", "drizzle":
            colors = [Color.blue.opacity(0.6), Color.gray]
        case "snow":
            colors = [Color.white, Color.blue.opacity(0.5)]
        default:
            colors = [Color.blue.opacity(0.6), Color.white]
        }
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
    }
}
