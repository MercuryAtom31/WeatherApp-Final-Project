//
//  MainWeatherView.swift
//  WeatherApp
//

import SwiftUI
import MapKit

/// The main view of the WeatherApp, displaying current weather, forecasts, news, and navigation options.
struct MainWeatherView: View {
    
    /// ViewModels to manage the data for various sections./
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var hourlyViewModel = HourlyForecastViewModel()
    @StateObject private var dailyViewModel = DailyForecastViewModel()
    @StateObject private var newsViewModel = WeatherNewsViewModel()

    /// State variables for navigation and map pins./
    @State private var showMap = false
    @State private var showHistoricalWeather = false
    @State private var pins: [MapPinData] = []

    var body: some View {
        ZStack {
            
            /// Dynamic background gradient based on the current weather condition./
            backgroundGradient(for: viewModel.currentWeather?.weather.first?.description)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    /// Current Weather Section
                    if let weather = viewModel.currentWeather {
                        CurrentWeatherView(
                            temperature: String(format: "%.1f°C", weather.main.temp),
                            condition: weather.weather.first?.description.capitalized ?? "",
                            location: weather.name,
                            iconURL: viewModel.iconURL,
                            humidity: String(weather.main.humidity),
                            windSpeed: String(format: "%.2f km/h", weather.wind.speed)
                        )
                    } else {
                        ProgressView("Loading Current Weather...")
                    }

                    /// Hourly Forecast
                    if !hourlyViewModel.hourlyForecast.isEmpty {
                        HourlyForecastView(hourlyForecast: hourlyViewModel.hourlyForecast)
                    }

                    // Daily Forecast
                    if !dailyViewModel.dailyForecasts.isEmpty {
                        DailyForecastView(dailyForecasts: dailyViewModel.dailyForecasts)
                    }

                    /// Weather News Section
                    WeatherNewsView(articles: newsViewModel.newsArticles)

                    /// Buttons Section
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
                    .padding(.bottom)
                }
                .padding()
            }
        }
        /// Fetch data when the view appears./
        .onAppear {
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

    /// Handles fetching weather data for a specific map coordinate and adds a new map pin.
    /// - Parameter coordinate: The location's latitude and longitude.
    private func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        
        /// Generate random placeholder values for missing parameters
        let randomTemp = String(format: "%.1f", Double.random(in: -10...30))
        let tempValue = randomTemp.toDouble() /// Safely convert the randomTemp to Double
        
        let randomMinTemp = String(format: "%.1f", Double.random(in: -15...(tempValue - 1)))
        let randomMaxTemp = String(format: "%.1f", Double.random(in: (tempValue + 1)...35))
        let randomWindSpeed = String(format: "%.2f", Double.random(in: 0...20))
        let randomHumidity = Int.random(in: 30...90)

        /// Create a new MapPinData instance with all required arguments
        let newPin = MapPinData(
            coordinate: coordinate,
            temperature: randomTemp,
            minTemp: randomMinTemp,
            maxTemp: randomMaxTemp,
            windSpeed: randomWindSpeed,
            humidity: "\(randomHumidity)%"
        )
        
        pins.append(newPin)
    }

    /// Generates a background gradient based on the current weather condition.
    /// - Parameter condition: The weather condition as a string.
    /// - Returns: A `LinearGradient` view with appropriate colors.
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
