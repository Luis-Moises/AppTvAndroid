import 'package:evaluation_app/screens/service.dart';
import 'package:evaluation_app/screens/weather_screen.dart';
import 'package:flutter/material.dart';



class WatchScreen extends StatelessWidget {
  WatchScreen({super.key});
  final WeatherService weatherService = WeatherService();

  @override
  Widget build(BuildContext context) {
    return WeatherWidget(weatherService: weatherService);
  }
}



