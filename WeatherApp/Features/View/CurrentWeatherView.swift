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
        }
    }
}
