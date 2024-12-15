//
//  WeatherBackground.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-05.
//

import SwiftUI

struct WeatherBackground: View {
    let condition: String
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: backgroundColors(for: condition)),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
    
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
