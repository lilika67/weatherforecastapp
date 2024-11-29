import 'package:flutter/material.dart';
import 'package:weather_app/dashboard.dart';
import 'package:weather_app/details_screen.dart';
import 'package:weather_app/search_screen.dart';

class WeatherHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.search), text: "Search"),
              Tab(icon: Icon(Icons.dashboard), text: "Dashboard"),
              Tab(icon: Icon(Icons.info), text: "Details"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CitySearchScreen(),
            WeatherDashboardScreen(),
            WeatherDetailsScreen(),
          ],
        ),
      ),
    );
  }
}
