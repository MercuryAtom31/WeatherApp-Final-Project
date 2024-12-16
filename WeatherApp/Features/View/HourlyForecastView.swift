//
//  HourlyForecastView.swift
//  WeatherApp
//

import SwiftUI

/// A SwiftUI view for displaying an hourly weather forecast in a horizontal scrollable format.
struct HourlyForecastView: View {
    var hourlyForecast: [ForecastResponse.Forecast]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(hourlyForecast, id: \.dt) { forecast in
                    VStack {
                        /// Display the forecast time using a formatted string./
                        Text("\(Date(timeIntervalSince1970: TimeInterval(forecast.dt)), formatter: hourFormatter)")
                            .font(.caption)
                            .foregroundColor(.white)
                        /// Display the weather icon using an asynchronous image loader./
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather.first?.icon ?? "")@2x.png")) { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                        } placeholder: {
                            ProgressView()/// Show a loading indicator while the image loads.
                        }
                        /// Display the temperature in Celsius./
                        Text("\(forecast.main.temp, specifier: "%.1f")°C")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
            }
            .padding()
        }
    }

    /// A date formatter to format the forecast time into a 12-hour format with AM/PM.
    private var hourFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }
}
