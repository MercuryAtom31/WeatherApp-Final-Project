//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import SwiftUI

struct WeatherDetailsView: View {
    let pin: MapPinData

    var body: some View {
        VStack(spacing: 8) {
            Text("Weather Details")
                .font(.headline)
                .padding(.bottom, 5)

            HStack {
                WeatherDetailItem(label: "Min Temp", value: "\(pin.minTemp)°C")
                Spacer()
                WeatherDetailItem(label: "Max Temp", value: "\(pin.maxTemp)°C")
            }

            HStack {
                WeatherDetailItem(label: "Wind Speed", value: pin.windSpeed)
                Spacer()
                WeatherDetailItem(label: "Humidity", value: pin.humidity)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct WeatherDetailItem: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}
