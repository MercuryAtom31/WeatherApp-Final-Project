//
//  WeatherBackground.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI

/// A view that provides a dynamic background based on the weather condition.
struct WeatherBackground: View {
    
    /// The weather condition used to determine the background colors.
    let condition: String
    
    var body: some View {
        
        /// Create a vertical gradient based on the weather condition.
        LinearGradient(
            gradient: Gradient(colors: backgroundColors(for: condition)),
            startPoint: .top,/// Start the gradient at the top./
            endPoint: .bottom /// End the gradient at the bottom.
        )
        .edgesIgnoringSafeArea(.all)/// Extend the background to cover the entire screen.
    }
    
    /// Determines the gradient colors based on the weather condition.
    /// - Parameter condition: The weather condition as a string (e.g., "sunny", "cloudy").
    /// - Returns: An array of colors for the gradient.
    func backgroundColors(for condition: String) -> [Color] {
        switch condition.lowercased() {
        case "sunny":
            return [Color.blue, Color.yellow]
        case "cloudy":
            return [Color.gray, Color.white]
        case "rainy":
            return [Color.blue, Color.gray]
        case "snowy":
            return [Color.white, Color.gray]
        default:
            return [Color.gray, Color.black]
        }
    }
}
