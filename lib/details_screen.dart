import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
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
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.currentWeather;

    if (weather == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Weather Details'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/clear.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  weather.cityName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _weatherDetailRow(
                  'Temperature',
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  Icons.thermostat,
                ),
                const SizedBox(height: 10),
                _weatherDetailRow(
                  'Description',
                  weather.description,
                  Icons.cloud,
                ),
                const SizedBox(height: 10),
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
          ),
        ),
      ),
    );
  }
}
