//
//  MainWeatherView.swift
//  WeatherApp
//

import SwiftUI
import MapKit

struct MainWeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var hourlyViewModel = HourlyForecastViewModel()
    @StateObject private var dailyViewModel = DailyForecastViewModel()
    
    @State private var pins: [MapPinData] = [] // Holds weather pins
    @State private var showMap = false // Controls the map sheet display
    @State private var showHistoricalWeather = false // Controls the historical weather sheet
    
    var body: some View {
        ZStack {
            // Background gradient
            backgroundGradient(for: viewModel.currentWeather?.weather.first?.description)
                .edgesIgnoringSafeArea(.all)
            
            // Main content
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
                    
                    // Buttons for Advanced Features
                    HStack(spacing: 20) {
                        Button("View Map") {
                            showMap = true
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("View Historical Weather") {
                            showHistoricalWeather = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            // Fetch data when view appears
            viewModel.fetchWeatherData(for: "Montreal")
            hourlyViewModel.fetchHourlyForecast(for: "Montreal")
            dailyViewModel.fetchDailyForecast(lat: 45.5088, lon: -73.5878)
        }
        .sheet(isPresented: $showMap) {
            WeatherMapView(pins: $pins, fetchWeather: fetchWeatherData)
        }
        .sheet(isPresented: $showHistoricalWeather) {
            HistoricalWeatherView()
        }
    }
    
    // Simulate fetching weather data for a location
    private func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        let randomTemp = String(format: "%.1f", Double.random(in: -10...30))
        let randomMinTemp = String(format: "%.1f", Double.random(in: -20...10))
        let randomMaxTemp = String(format: "%.1f", Double.random(in: 10...30))
        let randomWindSpeed = String(format: "%.1f", Double.random(in: 1...15))
        let randomHumidity = "\(Int.random(in: 40...90))%"
        
        let newPin = MapPinData(
            coordinate: coordinate,
            temperature: randomTemp,
            minTemp: randomMinTemp,
            maxTemp: randomMaxTemp,
            windSpeed: randomWindSpeed,
            humidity: randomHumidity
        )
        pins.append(newPin)
    }
    
    // Background gradient based on weather condition
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
