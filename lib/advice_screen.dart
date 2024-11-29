import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class WeatherAdviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Advice'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/advic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      'Weather Advice for You!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.7),
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Weather advice content
                    Consumer<WeatherProvider>(
                      builder: (context, weatherProvider, child) {
                        // Check for loading state
                        if (weatherProvider.isLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // Check if error exists
                        if (weatherProvider.error.isNotEmpty) {
                          return Center(
                            child: Text(
                              weatherProvider.error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        final weather = weatherProvider.currentWeather;

                        // Check if weather is null before proceeding
                        if (weather == null) {
                          return const Center(
                            child: Text(
                              'No weather data available.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        // Ensure weather is not null before using its properties
                        final advice = _getWeatherAdvice(weather);

                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              // City name
                              Text(
                                weather.cityName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              // Weather advice
                              Text(
                                advice,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getWeatherAdvice(Weather weather) {
    if (weather.temperature > 30) {
      return 'It\'s hot! Stay hydrated and avoid prolonged exposure to the sun.';
    } else if (weather.temperature < 10) {
      return 'It\'s cold! Dress warmly and consider indoor activities.';
    } else if (weather.description.toLowerCase().contains('rain')) {
      return 'It\'s raining! Carry an umbrella and wear waterproof shoes.';
    } else if (weather.description.toLowerCase().contains('snow')) {
      return 'It\'s snowing! Dress warmly and drive cautiously.';
    } else {
      return 'The weather looks great! Enjoy your day.';
    }
  }
}
