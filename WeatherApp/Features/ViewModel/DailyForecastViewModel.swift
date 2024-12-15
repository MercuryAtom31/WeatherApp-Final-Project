//
//  DailyForecastViewModel.swift
//  WeatherApp
//
//  Created by Hichem on 2024-12-14.
//

import Foundation

class DailyForecastViewModel: ObservableObject {
    @Published var dailyForecasts: [OpenMeteoDailyForecastData] = []
    @Published var errorMessage: String?

    private let service = OpenMeteoService()
    
    func fetchDailyForecast(lat: Double, lon: Double) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=America%2FToronto"

        service.fetchDailyData(urlString: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dailyData):
                    self.dailyForecasts = dailyData
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

