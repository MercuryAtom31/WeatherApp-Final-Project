//
//  WeeklyForecastView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI

/// A SwiftUI view displaying the weekly weather forecast.
struct WeeklyForecastView: View {
    
    /// The list of forecasts to display, passed as a parameter.
    var weeklyForecast: [ForecastResponse.Forecast]

    var body: some View {
        VStack(alignment: .leading) {
            /// Header for the weekly forecast section.
            Text("Weekly Forecast")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            /// Iterate over the forecasts and display each as a row./
            ForEach(weeklyForecast, id: \.dt) { forecast in
                HStack {
                    Text("\(Date(timeIntervalSince1970: TimeInterval(forecast.dt)), formatter: dateFormatter)")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    /// Display the weather icon using an asynchronous image loader./
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather.first?.icon ?? "")@2x.png")) { image in
                        image
                            .resizable()
                            .frame(width: 30, height: 30)
                    } placeholder: {
                        ProgressView()/// Show a loading indicator while the image loads.
                    }
                    Text("\(forecast.main.temp, specifier: "%.1f")°C")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.vertical, 5)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .background(Color.black.opacity(0.3)) /// Add a translucent background for contrast.
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
    }

    /// A date formatter to format the forecast date into a readable format.
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

