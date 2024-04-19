import 'package:flutter/material.dart';
import 'package:live_weather_api_demo/grouped_weather.dart';
import 'package:live_weather_api_demo/weather_api_service.dart';

class DailyWeatherTile extends StatelessWidget {
  final GroupedWeather day;

  const DailyWeatherTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).primaryColorLight,
        elevation: 7,
        child: ListTile(
          leading: Text(
            day.day,
            style: const TextStyle(fontSize: 24),
          ),
          title: Text(day.description, style: const TextStyle(fontSize: 22)),
          subtitle: Text("Min: ${day.min}°C - Max: ${day.max}°C",
              style: const TextStyle(fontSize: 18)),
          trailing: Image.network(WeatherApiService.iconUrlFromId(day.icon)),
        ));
  }
}
