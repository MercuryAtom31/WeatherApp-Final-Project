//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import SwiftUI

/// A SwiftUI view for displaying a horizontal scrollable daily weather forecast.
struct DailyForecastView: View {
    
    /// The daily forecast data to display.
    var dailyForecasts: [OpenMeteoDailyForecastData]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Daily Forecast")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(dailyForecasts) { forecast in
                        VStack(spacing: 8) {
                            Text(forecast.date) /// Date
                                .font(.subheadline)
                                .foregroundColor(.white) /// Adjust text color for visibility
                                .bold()

                            /// Display the maximum and minimum temperatures./
                            Text("\(forecast.maxTemp, specifier: "%.1f")°C / \(forecast.minTemp, specifier: "%.1f")°C")
                                .font(.body)
                                .foregroundColor(.white)
                                .bold()

                            /// Placeholder for future weather icon if needed
                            Image(systemName: "cloud.sun.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black.opacity(0.4)) /// Add a semi-transparent background
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

