//
//  WeatherNews.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

struct WeatherNews: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let link: String
}
