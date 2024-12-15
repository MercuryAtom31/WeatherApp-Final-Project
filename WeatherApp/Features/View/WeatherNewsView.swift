//
//  WeatherNewsView.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-15.
//

import SwiftUI

struct WeatherNewsView: View {
    let articles: [NewsArticle]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weather News")
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            ForEach(articles) { article in
                VStack(alignment: .leading, spacing: 5) {
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
