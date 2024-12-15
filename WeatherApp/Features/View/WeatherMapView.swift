//
//  WeatherMapView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI
import MapKit

struct WeatherMapView: View {
    @Binding var pins: [MapPinData] // Holds weather pins
    let fetchWeather: (CLLocationCoordinate2D) -> Void // Fetch weather closure

    var body: some View {
        ZStack {
            MapViewRepresentable(mapPins: $pins, fetchWeather: fetchWeather)
                .edgesIgnoringSafeArea(.all)

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
