//
//  WeatherMapView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI
import MapKit

struct WeatherMapView: View {
    var locationName: String

    var body: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 45.5088, longitude: -73.5878),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        ))
        .edgesIgnoringSafeArea(.all)
        .overlay(
            Text("Weather Map for \(locationName)")
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .padding(),
            alignment: .bottom
        )
    }
}
