import 'dart:async';
import 'package:evaluation_app/screens/model.dart';
import 'package:evaluation_app/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatefulWidget {
  final WeatherService weatherService;

  const WeatherWidget({required this.weatherService});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late WeatherData _weatherData;
  late String _hourString;
  late String _minuteString;
  late String _amPmString;

  List<LinearGradient> _gradients = [
    LinearGradient(colors: [Colors.blue, Colors.purple]),
    LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
    // Add more gradient combinations as needed
  ];

  int _currentGradientIndex = 0;

  @override
  void initState() {
    super.initState();
    _weatherData = WeatherData(
      cityName: '',
      temperature: 0,
      description: '',
      iconUrl: '',
    );
    _getTime();
    _getWeather();
  }

  void _getTime() {
    final now = DateTime.now();
    final hourFormatter = DateFormat('hh');
    final minuteFormatter = DateFormat('mm');
    final amPmFormatter = DateFormat('a');
    _hourString = hourFormatter.format(now);
    _minuteString = minuteFormatter.format(now);
    _amPmString = amPmFormatter.format(now);
    Timer.periodic(Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      final hourFormatter = DateFormat('hh');
      final minuteFormatter = DateFormat('mm');
      final amPmFormatter = DateFormat('a');
      setState(() {
        _hourString = hourFormatter.format(now);
        _minuteString = minuteFormatter.format(now);
        _amPmString = amPmFormatter.format(now);
      });
    });
  }

  Future<void> _getWeather() async {
    try {
      final weatherData =
          await widget.weatherService.getWeather('San Juan del Rio');
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  void _changeGradient() {
    setState(() {
      _currentGradientIndex = (_currentGradientIndex + 1) % _gradients.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: _gradients[_currentGradientIndex],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weather Information
              Column(
                children: [
                  Text(
                    '${_weatherData.cityName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_weatherData.temperature}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Button to change background gradient
              ElevatedButton(
                onPressed: _changeGradient,
                child: Text("Change Background"),
              ),
              SizedBox(height: 20),
              // Date Text
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Time Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _hourString,
                          style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ':',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: _minuteString,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _amPmString,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

