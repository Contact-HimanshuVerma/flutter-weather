import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapi/models/weather_model.dart';
import 'package:weatherapi/services/weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _weatherService = WeatherService("8f75c73e7ff557d6ebcf41ddd6fcaf18");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city..."),
            Text("${_weather?.temperature.round()}")
          ],
        ),
      ),
    );
  }
}
