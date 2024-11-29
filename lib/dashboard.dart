import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/details_screen.dart';
import 'weather_provider.dart';

class WeatherDashboardScreen extends StatelessWidget {
  final Map<String, String> weatherBackgrounds = {
    'clear sky': 'assets/clear.jpg',
    'rain': 'assets/rain.jpg',
    'clouds': 'assets/cloud.jpg',
    'snow': 'assets/snow.jpg',
    'thunderstorm': 'assets/thunder.jpg',
    'mist': 'assets/mist.jpg',
  };

  String _getBackgroundImage(String description) {
    if (description.toLowerCase().contains('rain')) {
      return 'assets/rain.jpg';
    } else if (description.toLowerCase().contains('clear')) {
      return 'assets/clear.jpg';
    } else if (description.toLowerCase().contains('cloud')) {
      return 'assets/cloud.jpg';
    } else if (description.toLowerCase().contains('snow')) {
      return 'assets/snow.jpg';
    } else if (description.toLowerCase().contains('thunderstorm')) {
      return 'assets/thunder.jpg';
    } else if (description.toLowerCase().contains('mist')) {
      return 'assets/mist.jpg';
    }
    return 'assets/default_weather.jpg';
  }

  Widget _weatherDetailRow(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Weather Dashboard'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.error.isNotEmpty) {
            return Center(
              child: Text(
                weatherProvider.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final weather = weatherProvider.currentWeather;
          if (weather == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final backgroundImage = _getBackgroundImage(weather.description);

          return Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),
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
              // Center content
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // City name and weather icon
                        Column(
                          children: [
                            Text(
                              weather.cityName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Image.network(
                              'http://openweathermap.org/img/wn/${weather.icon}@4x.png',
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Temperature display
                        Text(
                          '${weather.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Weather description
                        Text(
                          weather.description,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Weather details
                        Column(
                          children: [
                            _weatherDetailRow(
                              'Humidity',
                              '${weather.humidity}%',
                              Icons.water_drop,
                            ),
                            const SizedBox(height: 10),
                            _weatherDetailRow(
                              'Wind Speed',
                              '${weather.windSpeed} m/s',
                              Icons.wind_power,
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // Button to view details
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherDetailsScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'View Details',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
