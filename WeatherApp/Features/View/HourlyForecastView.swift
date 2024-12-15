//
//  HourlyForecastView.swift
//  WeatherApp
//

import SwiftUI

struct HourlyForecastView: View {
    var hourlyForecast: [ForecastResponse.Forecast]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(hourlyForecast, id: \.dt) { forecast in
                    VStack {
                        Text("\(Date(timeIntervalSince1970: TimeInterval(forecast.dt)), formatter: hourFormatter)")
                            .font(.caption)
                            .foregroundColor(.white)
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(forecast.weather.first?.icon ?? "")@2x.png")) { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                        } placeholder: {
                            ProgressView()
                        }
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

    private var hourFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }
}
