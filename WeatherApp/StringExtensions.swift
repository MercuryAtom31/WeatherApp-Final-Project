//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

extension String {
    /// Converts a String to Double. Returns 0.0 if conversion fails.
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
}
