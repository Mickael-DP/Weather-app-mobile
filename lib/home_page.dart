import 'package:flutter/material.dart';
import 'package:live_weather_api_demo/api_key_service.dart';
import 'package:live_weather_api_demo/drawer_menu.dart';
import 'package:live_weather_api_demo/geo_position.dart';
import 'package:live_weather_api_demo/location_service.dart';
import 'package:live_weather_api_demo/weather_api_response.dart';
import 'package:live_weather_api_demo/weather_api_service.dart';
import 'package:location/location.dart';
import 'package:live_weather_api_demo/forecast_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  LocationData? locationData;
  GeoPosition? userPosition;
  WeatherApiResponse? weatherApiResponse;

  List<String> cities = ["Paris", "Nice", "Marseille"];

  @override
  void initState() {
    getUserPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Weather Api Demo"),
        ),
        body: ForcastView(weatherApiResponse: weatherApiResponse),
        drawer: DrawerMenu(cities: cities, onTap: onMenuItemTap));
  }

  //getUserLocation() async {
  // final currentLocation = await LocationService().getLocation();
  // setState(() {
  // locationData = currentLocation;
  // });
  //}

  getUserPosition() async {
    final currentPosition = await LocationService().getCity();
    setState(() {
      userPosition = currentPosition;
    });
    final currentResponses =
        await WeatherApiService().callWeatherApi(userPosition!);
    setState(() {
      weatherApiResponse = currentResponses;
    });
  }

  onMenuItemTap(String s) {
    debugPrint("onTap: $s");
  }
}
