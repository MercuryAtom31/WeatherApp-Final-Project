//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import SwiftUI
import CoreLocation

struct WeatherDetailsView: View {
    let pin: MapPinData
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Weather Details")
                .font(.headline)
                .bold()
            HStack {
                VStack {
                    Text("Temp")
                        .font(.subheadline)
                    Text("\(pin.temperature)°C")
                        .font(.title2)
                        .bold()
                }
                Spacer()
                VStack {
                    Text("Latitude")
                        .font(.subheadline)
                    Text(String(format: "%.2f", pin.coordinate.latitude))
                }
                Spacer()
                VStack {
                    Text("Longitude")
                        .font(.subheadline)
                    Text(String(format: "%.2f", pin.coordinate.longitude))
                }
            }
        }
        .padding()
    }
}
