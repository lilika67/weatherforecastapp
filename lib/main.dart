import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/search_screen.dart';
import 'weather_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CitySearchScreen(),
      ),
    );
  }
}
