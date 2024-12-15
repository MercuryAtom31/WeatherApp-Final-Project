//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI

struct CurrentWeatherView: View {
    var temperature: String
    var condition: String
    var location: String
    var iconURL: String?
    var humidity: String? = nil
    var windSpeed: String? = nil

    var body: some View {
        VStack(spacing: 16) { // Add spacing for better alignment
            VStack {
                Text(location)
                    .font(.largeTitle)
                    .foregroundColor(.white) // White for better visibility
                    .padding(.top)

                // Weather icon
                if let iconURL = iconURL, let url = URL(string: iconURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }

            Text(temperature)
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.white)

            Text(condition)
                .font(.title2)
                .foregroundColor(.white)

            // Updated weather details: Humidity and Wind Speed
            if let humidity = humidity, let windSpeed = windSpeed {
                HStack(spacing: 40) { // Adjust spacing
                    VStack {
                        Text("Humidity")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(humidity)%")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }

                    VStack {
                        Text("Wind")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(windSpeed) km/h")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 8) // Add padding for better alignment
            }
        }
    }
}
