# WeatherApp

**WeatherApp** is a modern iOS application that provides current weather data, seven-day forecasts, historical weather information, and weather-related news. Built with Swift and SwiftUI, the app integrates local static JSON data and live weather APIs to deliver a seamless user experience with clean, functional design.

---

## Table of Contents
1. [Features](#features)
2. [Technologies Used](#technologies-used)
3. [Folder Structure](#folder-structure)
4. [Setup Instructions](#setup-instructions)
5. [Code Quality and Practices](#code-quality-and-practices)

---

## Features
### 🌤 **Current Weather Conditions**
- Displays the current weather, including temperature, humidity, wind speed, and a weather icon.
- Integrates with the Open-Meteo API to fetch real-time data.
- Dynamic backgrounds change based on weather conditions (e.g., clear sky, snow, rain).

### 📅 **Daily and Hourly Forecasts**
- Provides a 7-day weather forecast with minimum and maximum temperatures.
- Shows an hourly breakdown of the weather conditions.
- Scrollable views for easy navigation of forecasts.

### 📊 **Historical Weather Data**
- Fetches and displays weather information from a static local JSON file.
- Sorting capabilities based on date, temperature (high/low), wind speed, and humidity.
- Filter functionality to search by weather condition.

### 📰 **Weather News**
- Displays weather-related news articles with titles, descriptions, and "Read More" links.
- Links to trusted weather news sources (e.g., WeatherBug).

### 🗺 **Interactive Weather Map**
- Allows users to view map pins with random weather conditions for selected coordinates.
- Smooth map interactions via MapKit integration.

---

## Technologies Used
- **Language**: Swift, SwiftUI
- **API Integration**: Open-Meteo API
- **Frameworks**: MapKit, SwiftUI
- **Storage**: Local JSON Files (`local_weather.json`, `news_articles.json`)
- **Tools**: Xcode 15, iOS Simulator

---

## Folder Structure
```
WeatherApp
├── Features
│   ├── Model
│   │   ├── DailyWeather.swift
│   │   ├── Forecast.swift
│   │   ├── HistoricalWeather.swift
│   │   ├── Location.swift
│   │   ├── Weather.swift
│   │   └── WeatherNews.swift
│   ├── View
│   │   ├── CurrentWeatherView.swift
│   │   ├── DailyForecastView.swift
│   │   ├── HourlyForecastView.swift
│   │   ├── MapViewRepresentable.swift
│   │   ├── WeatherMapView.swift
│   │   ├── WeatherNewsView.swift
│   │   └── MainWeatherView.swift
│   ├── ViewModel
│   │   ├── DailyForecastViewModel.swift
│   │   ├── HourlyForecastViewModel.swift
│   │   ├── WeatherViewModel.swift
│   │   └── WeatherNewsViewModel.swift
│
├── Resources
│   ├── local_weather.json
│   ├── news_articles.json
│
├── Services
│   ├── LocationManager.swift
│   ├── OpenMeteoService.swift
│   └── WeatherService.swift
│
├── Assets
│   ├── ContentView.swift
│   └── StringExtensions.swift
│
└── WeatherAppApp.swift
```

---

## Setup Instructions

### Prerequisites
1. **Xcode 15+**: Ensure Xcode is installed on your system.
2. **iOS Simulator or Device**: Run the app on a simulator (iOS 18) or a physical iPhone device.

### Steps to Run
1. Clone this repository to your local system:
   ```bash
   git clone https://github.com/yourusername/WeatherApp.git
   ```
2. Open the project in Xcode:
   ```bash
   cd WeatherApp
   open WeatherApp.xcodeproj
   ```
3. Ensure the required JSON files are present in the `Resources` folder.
4. Run the project:
   - Select a simulator or device.
   - Press `Cmd + R` or click the **Run** button in Xcode.

---

## Code Quality and Practices
- **Clean Code**: 
   - Code adheres to Swift naming conventions and clean coding practices.
   - Classes and files are logically organized (MVVM architecture).
- **Comments**:
   - Each class, method, and critical section of the code has descriptive comments.
   - Example:
     ```swift
     /// Fetches the current weather for a given city name.
     func fetchWeatherData(for city: String) {
         ...
     }
     ```
- **Error Handling**:
   - Safe decoding of JSON files with appropriate error handling.
   - Random placeholder data is generated for weather map pins when needed.
- **Scalability**:
   - Easy to add new features (e.g., additional weather conditions, API endpoints).

---

## Acknowledgments
- [Open-Meteo API](https://open-meteo.com/)
- [WeatherBug News](https://www.weatherbug.com/)
- Built with ❤️ using SwiftUI and MapKit.

---

## Screenshots
### Current Weather
![Current Weather](screenshot_current_weather.png)

### Daily Forecast
![Daily Forecast](screenshot_daily_forecast.png)

### Weather News
![Weather News](screenshot_weather_news.png)

---

Enjoy exploring the **WeatherApp**! 🌦✨
