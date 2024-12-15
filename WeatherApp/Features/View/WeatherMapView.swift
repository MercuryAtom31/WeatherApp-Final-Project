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

struct MapViewRepresentable: UIViewRepresentable {
    @Binding var mapPins: [MapPinData]
    let fetchWeather: (CLLocationCoordinate2D) -> Void
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
        }
        
        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began else { return }
            let mapView = gesture.view as! MKMapView
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            parent.fetchWeather(coordinate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress))
        mapView.addGestureRecognizer(longPressGesture)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        let annotations = mapPins.map { pin -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = pin.coordinate
            annotation.title = "\(pin.temperature)°C"
            return annotation
        }
        uiView.addAnnotations(annotations)
    }
}
