import 'package:flutter/material.dart';
import 'package:live_weather_api_demo/current_weather_view.dart';
import 'package:live_weather_api_demo/weather_api_response.dart';

class ForcastView extends StatelessWidget {
  final WeatherApiResponse? weatherApiResponse;

  //Ctor
  const ForcastView({required this.weatherApiResponse});

  @override
  Widget build(BuildContext context) {
    return (weatherApiResponse == null)
        ? const Center(child: Text("No data", style: TextStyle(fontSize: 24)))
        : Column(
            children: [
              CurrentWeatherView(forecast: weatherApiResponse!.list.first),
            ],
          );
  }
}
