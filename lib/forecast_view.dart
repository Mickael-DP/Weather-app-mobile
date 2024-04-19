import 'package:flutter/material.dart';
import 'package:live_weather_api_demo/current_weather_view.dart';
import 'package:live_weather_api_demo/daily_weather_tile.dart';
import 'package:live_weather_api_demo/grouped_weather.dart';
import 'package:live_weather_api_demo/weather_api_response.dart';
import 'package:live_weather_api_demo/weather_api_service.dart';

class ForcastView extends StatelessWidget {
  final WeatherApiResponse? weatherApiResponse;

  //Ctor
  const ForcastView({required this.weatherApiResponse});

  @override
  Widget build(BuildContext context) {
    if (weatherApiResponse == null) {
      return const Center(
        child: Text("No data", style: TextStyle(fontSize: 24)),
      );
    }

    List<GroupedWeather> weatherByDay =
        WeatherApiService.groupByDay(weatherApiResponse!);

    if (weatherByDay.isEmpty) {
      return const Center(
        child:
            Text("No weather data available", style: TextStyle(fontSize: 24)),
      );
    }

    return Column(
      children: [
        CurrentWeatherView(
            forecast: weatherApiResponse!.list.first,
            cityName: weatherApiResponse!.city.name),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) =>
                DailyWeatherTile(day: weatherByDay[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: weatherByDay.length,
          ),
        ),
      ],
    );
  }
}
