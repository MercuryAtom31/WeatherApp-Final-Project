//
//  MapViewRepresentable.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI
import MapKit

/// A `UIViewRepresentable` wrapper for integrating an `MKMapView` into SwiftUI.
/// Displays weather map pins and handles user interactions.
struct MapViewRepresentable: UIViewRepresentable {
    
    /// A binding property to hold the array of map pins representing weather data.
    @Binding var mapPins: [MapPinData]
    
    /// A closure to fetch weather data for a given coordinate.
    let fetchWeather: (CLLocationCoordinate2D) -> Void

    /// A coordinator class to manage `MKMapView` interactions and delegate methods.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable

        /// Initializes the coordinator with a reference to the parent view.
        /// - Parameter parent: The parent `MapViewRepresentable`.
        init(parent: MapViewRepresentable) {
            self.parent = parent
        }

        /// Handles long-press gestures on the map.
        /// - Parameter gesture: The gesture recognizer detecting the long press.
        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            guard gesture.state == .began else { return }/// Only handle the initial gesture state.
            let mapView = gesture.view as! MKMapView
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            parent.fetchWeather(coordinate)/// Fetch weather data for the pressed location.
        }
    }

    /// Creates a coordinator for managing the map view's delegate methods and interactions.
    /// - Returns: An instance of `Coordinator`.
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    /// Creates and configures the `MKMapView` to be displayed in SwiftUI.
    /// - Parameter context: The context provided by SwiftUI.
    /// - Returns: A configured `MKMapView` instance.
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let longPressGesture = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLongPress)
        )
        mapView.addGestureRecognizer(longPressGesture)
        return mapView
    }

    /// Updates the `MKMapView` with the latest map pins.
    /// - Parameters:
    ///   - uiView: The `MKMapView` instance.
    ///   - context: The context provided by SwiftUI.
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        
        /// Create annotations for each map pin.
        let annotations = mapPins.map { pin -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = pin.coordinate
            annotation.title = "\(pin.temperature)°C"
            return annotation
        }
        uiView.addAnnotations(annotations)/// Add the new annotations to the map.
    }
}

