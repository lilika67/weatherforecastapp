import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather {
  final String cityName;
  final String description;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String icon;

  Weather({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      icon: json['weather'][0]['icon'],
    );
  }
}

class WeatherProvider with ChangeNotifier {
  Weather? currentWeather;
  String error = '';

  bool? get isLoading => false; // Added to store error messages

  Future<void> fetchWeather(String city) async {
    const String apiKey = '1fc2d36e86f8adfb6e3e28d6889ae124';
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentWeather = Weather.fromJson(data);
        error = ''; // Clear any previous errors
        notifyListeners();
      } else {
        error = 'Failed to load weather. Please check the city name.';
        notifyListeners();
      }
    } catch (e) {
      error = 'An error occurred: $e';
      notifyListeners();
    }
  }
}
