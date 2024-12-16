//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI

/// A  SwiftUI view for displaying the current weather details./
struct CurrentWeatherView: View {
    var temperature: String
    var condition: String
    var location: String
    var iconURL: String?
    var humidity: String // Added parameter
    var windSpeed: String // Added parameter
    
    /// The opacity state for animation effects.
    @State private var opacity = 0.0

    var body: some View {
        VStack(spacing: 16) {
            
            /// Display the location name.
            Text(location)
                .font(.largeTitle)
                .foregroundColor(.white)
                .opacity(opacity) /// Animate the opacity./
                .animation(.easeIn(duration: 1.0), value: opacity)/// Smooth fade-in animation.
            
            /// Display the weather icon if a valid URL is provided./
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

            /// Display additional weather details in a horizontal layout./
            HStack {
                /// Humidity Section/
                VStack {
                    Text("Humidity")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(humidity)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()

                /// Wind Speed Section/
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
        /// Trigger the fade-in animation on view appearance./
        .onAppear {
            opacity = 1.0 
        }
    }
}
