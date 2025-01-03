//
//  WeatherNews.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

/// A model representing a weather-related news article.
struct WeatherNews: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let link: String
}
