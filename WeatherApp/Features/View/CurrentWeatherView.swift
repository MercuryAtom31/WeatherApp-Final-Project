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
    var humidity: String // Added parameter
    var windSpeed: String // Added parameter
    
    @State private var opacity = 0.0

    var body: some View {
        VStack(spacing: 16) {
            Text(location)
                .font(.largeTitle)
                .foregroundColor(.white)
                .opacity(opacity)
                .animation(.easeIn(duration: 1.0), value: opacity)
            
            if let iconURL = iconURL, let url = URL(string: iconURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .opacity(opacity)
                } placeholder: {
                    ProgressView()
                }
            }

            Text(temperature)
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.white)
                .opacity(opacity)

            HStack {
                VStack {
                    Text("Humidity")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(humidity)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()

                VStack {
                    Text("Wind")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(windSpeed)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .opacity(opacity)
        }
        .onAppear {
            opacity = 1.0 // Trigger animation
        }
    }
}
