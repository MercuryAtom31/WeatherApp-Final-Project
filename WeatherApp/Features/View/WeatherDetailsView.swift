//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import SwiftUI

/// A view to display detailed weather information for a specific map pin.
struct WeatherDetailsView: View {
    
    /// The map pin data containing weather details.
    let pin: MapPinData

    var body: some View {
        VStack(spacing: 8) {
            Text("Weather Details")
                .font(.headline)
                .padding(.bottom, 5)

            /// Row displaying minimum and maximum temperature./
            HStack {
                WeatherDetailItem(label: "Min Temp", value: "\(pin.minTemp)°C")
                Spacer()
                WeatherDetailItem(label: "Max Temp", value: "\(pin.maxTemp)°C")
            }

            /// Row displaying wind speed and humidity./
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

/// A reusable view to display a labeled weather detail item.
struct WeatherDetailItem: View {
    
    /// The label for the detail (e.g., "Min Temp").
    let label: String
    
    /// The value for the detail (e.g., "12°C").
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
