//
//  WeatherNewsViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

/// Represents a news article related to weather.
struct NewsArticle: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let link: String
}
/// ViewModel responsible for managing and providing weather-related news articles.
class WeatherNewsViewModel: ObservableObject {
    
    /// Published property holding a list of weather news articles.
    @Published var newsArticles: [NewsArticle] = []

    /// Initializes the ViewModel and loads the news articles from a local JSON file.
    init() {
        loadNewsArticles()
    }
    /// Loads news articles from a JSON file.
    private func loadNewsArticles() {
        guard let url = Bundle.main.url(forResource: "news_articles", withExtension: "json") else {
            print("Failed to find news_articles.json")
            return
        }
        
        do {
            /// Read the file data and decode it into an array of `NewsArticle` objects./
            let data = try Data(contentsOf: url)
            let decodedNews = try JSONDecoder().decode([NewsArticle].self, from: data)
            self.newsArticles = decodedNews
        } catch {
            /// Handle errors during JSON decoding./
            print("Error decoding JSON: \(error)")
        }
    }
}
