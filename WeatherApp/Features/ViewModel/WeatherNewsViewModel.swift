//
//  WeatherNewsViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import Foundation

struct NewsArticle: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let link: String
}

class WeatherNewsViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticle] = []

    init() {
        loadNewsArticles()
    }

    private func loadNewsArticles() {
        guard let url = Bundle.main.url(forResource: "news_articles", withExtension: "json") else {
            print("Failed to find news_articles.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedNews = try JSONDecoder().decode([NewsArticle].self, from: data)
            self.newsArticles = decodedNews
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
