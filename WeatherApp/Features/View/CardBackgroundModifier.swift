//
//  CardBackgroundModifier.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI

/// A custom view modifier for styling card-like UI elements with padding, rounded corners, and shadows.
struct CardBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3)) /// Subtle card background
                    .shadow(color: Color.white.opacity(0.2), radius: 5, x: -5, y: -5) /// Top-left light
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 5, y: 5)   /// Bottom-right shadow
            )
    }
}

extension View {
    /// Applies the custom card styling to any view.
    /// - Returns: The styled view.
    func cardStyle() -> some View {
        self.modifier(CardBackgroundModifier())
    }
}
