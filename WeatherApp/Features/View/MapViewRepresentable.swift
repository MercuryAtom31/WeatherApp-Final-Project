//
//  MapViewRepresentable.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI
import MapKit

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
        let longPressGesture = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLongPress)
        )
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

