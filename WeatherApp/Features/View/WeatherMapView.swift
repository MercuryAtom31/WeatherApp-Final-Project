//
//  WeatherMapView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI
import MapKit

/// A SwiftUI view that displays an interactive map with weather-related pins.
struct WeatherMapView: View {
    
    /// A binding property to hold the array of map pins representing weather data.
    @Binding var pins: [MapPinData]
    
    /// A closure to fetch weather information based on a specific coordinate.
    let fetchWeather: (CLLocationCoordinate2D) -> Void // Fetch weather closure

    var body: some View {
        ZStack {
            
            /// Custom map view displaying weather pins and handling user interaction./
            MapViewRepresentable(mapPins: $pins, fetchWeather: fetchWeather)
                .edgesIgnoringSafeArea(.all)/// Extend the map view to fill the screen.

            /// Overlay weather details for the most recently added pin./
            if let lastPin = pins.last {
                // Overlay details for the last pin at the bottom
                VStack {
                    Spacer()
                    WeatherDetailsView(pin: lastPin)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding()
                }
            }
        }
    }
}
