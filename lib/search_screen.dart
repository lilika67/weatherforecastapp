import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dashboard.dart';
import 'weather_provider.dart';

class CitySearchScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherForecast App'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/weather.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay for text readability
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Text(
                      'Search City for Weather',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.7),
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // City Name Input Field
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _cityController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Enter City Name',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: 'E.g. New York, London, Tokyo',
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.black45,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Search Button
                    ElevatedButton(
                      onPressed: () {
                        final city = _cityController.text.trim();
                        if (city.isNotEmpty) {
                          Provider.of<WeatherProvider>(context, listen: false)
                              .fetchWeather(city)
                              .then((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherDashboardScreen(),
                              ),
                            );
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Get Weather Information'),
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
}
