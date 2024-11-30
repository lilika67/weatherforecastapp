# Weather App - Flutter

## Overview

This Weather App provides users with real-time weather data, including temperature, humidity, wind speed, and weather descriptions. Built with Flutter and using the Provider package for state management, the app offers a sleek and responsive design with multiple screens for different weather-related views.

## Source of api used

https://openweathermap.org/api

## Features

- **Current Weather Screen**: Displays current weather for user's location or selected city
- **Weather Advice Screen**: Provides personalized advice based on current weather conditions
- **Weather Details Screen**: Shows comprehensive weather data with icons and text
- **Gradient & Background Image**: Aesthetic design with dynamic background images
- **Responsive Layout**: Adapts to different screen sizes for phones and tablets

## Screens

### 1. Weather Advice Screen

- Displays background image with gradient overlay
- Shows weather-specific advice (e.g., "It's hot! Stay hydrated")
- Dynamic updates based on current weather data

### 2. Weather Details Screen

- In-depth weather information display
- Background image with gradient overlay
- Organized weather details in rows with icons
- Displays:
  - Temperature
  - Weather description
  - Humidity
  - Wind speed

### 3. Current Weather Screen

- Basic weather information layout
- Background image and gradient overlay
- Displays:
  - Current temperature
  - Weather description
  - Location details

## Dependencies

- `flutter`: Primary framework
- `provider`: State management
- `flutter_icons`:  custom icons package

## Code Structure

The app is structured around:
- Multiple screens (WeatherAdviceScreen, WeatherDetailsScreen, WeatherCurrentScreen)
- WeatherProvider for data management
- API integration for real-time weather data

### Helper Method: `_weatherDetailRow`

A reusable method to create structured weather detail rows with icons and text.

## UI Design Principles

- Simplicity and clarity
- Dynamic background images matching weather conditions
- Gradient overlays for text readability
- Responsive layout using MediaQuery


### Challenges

Integrating with external weather APIs like OpenWeatherMap presented several challenges:

Managing API keys securely

Handling rate limits

Minimizing unnecessary API calls

Ensuring app performance and responsiveness

