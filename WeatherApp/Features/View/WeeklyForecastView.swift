//
//  WeeklyForecastView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI

struct WeeklyForecastView: View {
    var weeklyForecast: [ForecastResponse.Forecast]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekly Forecast")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            ForEach(weeklyForecast, id: \.dt) { forecast in
                HStack {
                    Text("\(Date(timeIntervalSince1970: TimeInterval(forecast.dt)), formatter: dateFormatter)")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather.first?.icon ?? "")@2x.png")) { image in
                        image
                            .resizable()
                            .frame(width: 30, height: 30)
                    } placeholder: {
                        ProgressView()
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
        .background(Color.black.opacity(0.3)) // Add a slight background to separate the section
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

