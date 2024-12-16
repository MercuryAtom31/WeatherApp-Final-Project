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
WeatherApp/
├── Features/
│   ├── Model/
│   │   ├── DailyWeather.swift
│   │   ├── Forecast.swift
│   │   ├── ForecastResponse.swift
│   │   ├── HistoricalWeather.swift
│   │   ├── HourlyWeather.swift
│   │   ├── Location.swift
│   │   ├── MapPinData.swift
│   │   ├── OpenMeteoModels.swift
│   │   ├── Weather.swift
│   │   └── WeatherNews.swift
│   │
│   ├── ViewModel/
│   │   ├── DailyForecastViewModel.swift
│   │   ├── HistoricalWeatherViewModel.swift
│   │   ├── HourlyForecastViewModel.swift
│   │   ├── WeatherNewsViewModel.swift
│   │   ├── WeatherViewModel.swift
│   │   └── WeeklyForecastViewModel.swift
│   │
│   └── View/
│       ├── CurrentWeatherView.swift
│       ├── DailyForecastView.swift
│       ├── HistoricalWeatherView.swift
│       ├── HourlyForecastView.swift
│       ├── MainWeatherView.swift
│       ├── MapViewRepresentable.swift
│       ├── WeatherBackground.swift
│       ├── WeatherDetailsView.swift
│       ├── WeatherMapView.swift
│       ├── WeatherNewsView.swift
│       └── WeeklyForecastView.swift
│
├── Resources/
│   ├── local_weather.json
│   ├── news_articles.json
│   └── Assets.xcassets
│
├── Services/
│   ├── LocationManager.swift
│   ├── OpenMeteoService.swift
│   └── WeatherService.swift
│
├── App/
│   ├── WeatherAppApp.swift
│   ├── ContentView.swift
│   └── StringExtensions.swift
│
├── Tests/
│   ├── WeatherAppTests/
│   └── WeatherAppUITests/
│
└── Preview Content/
    └── Preview Assets/
```

---

## Setup Instructions

### Prerequisites
1. **Xcode 15+**: Ensure Xcode is installed on your system.
2. **iOS Simulator or Device**: Run the app on a simulator (iOS 18) or a physical iPhone device.

### Steps to Run
1. Clone this repository to your local system:
   ```bash
   git clone https://github.com/yourusername/WeatherApp.git](https://github.com/MercuryAtom31/WeatherApp-Final-Project.git
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

## APIs Used in WeatherApp

### 1. OpenWeather API
- **Base URL**: `https://api.openweathermap.org/data/2.5/`
- **Endpoints**:
  - **Current Weather**: Fetches real-time weather data for a city.  
    Example:  
    ```
    https://api.openweathermap.org/data/2.5/weather?q=Montreal&appid=YOUR_API_KEY&units=metric
    ```
  - **Hourly Forecast**: Retrieves hourly weather data.  
    Example:  
    ```
    https://api.openweathermap.org/data/2.5/forecast?q=Montreal&appid=YOUR_API_KEY&units=metric
    ```
  - **Daily Forecast**: (Optional) Provides 7-day forecasts.  
    Example:  
    ```
    https://api.openweathermap.org/data/2.5/forecast/daily?q=Montreal&cnt=7&appid=YOUR_API_KEY&units=metric
    ```

### 2. Open-Meteo API
- **Base URL**: `https://api.open-meteo.com/v1/forecast`
- **Endpoint**:
  - **Daily Weather Data**: Fetches daily high/low temperatures and weather codes.  
    Example:  
    ```
    https://api.open-meteo.com/v1/forecast?latitude=45.5088&longitude=-73.5878&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=America%2FToronto
    ```

These APIs power the app's real-time weather updates, hourly forecasts, and daily forecasts, enabling a rich user experience.  
Make sure to replace `YOUR_API_KEY` with a valid API key for OpenWeather API.

---

## Acknowledgments
- [Open-Meteo API](https://open-meteo.com/)
- OpenWeather API
- [WeatherBug News](https://www.weatherbug.com/)
- Built with ❤️ using SwiftUI and MapKit.

---

## Screenshots
### Current Weather
![Screenshot 2024-12-15 at 22 42 43](https://github.com/user-attachments/assets/0cc6bb40-2e13-421d-8f0b-715f1611749e)

### Historical Weather
![Screenshot 2024-12-15 at 22 42 16](https://github.com/user-attachments/assets/c16826bd-0b62-45ec-84a4-83254b82e615)

### Historical Weather Sorting by keyword
![Screenshot 2024-12-15 at 22 42 16](https://github.com/user-attachments/assets/8eefbc0f-a6a6-4e7d-85f8-00a1ad29ffb1)

### Weather News
![Screenshot 2024-12-15 at 22 43 01](https://github.com/user-attachments/assets/94f0cf47-30ce-4367-88d7-98be20182a02)


### When you click on one of the weather news article
![Screenshot 2024-12-15 at 22 43 10](https://github.com/user-attachments/assets/7b123189-d57c-43a8-b21f-80fa03303f71)

### When you pin a specific city to get its current weather conditions
![Screenshot 2024-12-15 at 22 43 29](https://github.com/user-attachments/assets/b4b2fca3-f7dd-41c0-9ca7-610dc4de05b3)


---

Enjoy exploring the **WeatherApp**! 🌦✨
