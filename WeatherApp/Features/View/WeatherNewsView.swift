//
//  WeatherNewsView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI

/// A SwiftUI view for displaying a list of weather-related news articles.
struct WeatherNewsView: View {
    
    /// The list of articles to display.
    let articles: [NewsArticle]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            /// Header for the news section.
            Text("Weather News")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            /// Iterate over the articles and display each as a separate entry./
            ForEach(articles) { article in
                VStack(alignment: .leading, spacing: 5) {
                    /// Display the article title with a tappable gesture to open the article link./
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            if let url = URL(string: article.link) {
                                UIApplication.shared.open(url)
                            }
                        }
                    Text(article.description)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                    /// Display a "Read more..." link with a tap gesture to open the article link./
                    Text("Read more...")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            if let url = URL(string: article.link) {
                                UIApplication.shared.open(url)
                            }
                        }
                }
                .padding(.vertical, 8)
            }
        }
        .padding()
        .background(Color.black.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
