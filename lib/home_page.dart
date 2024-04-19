import 'package:flutter/material.dart';
import 'package:live_weather_api_demo/add_city_view.dart';
import 'package:live_weather_api_demo/api_key_service.dart';
import 'package:live_weather_api_demo/data_persistence.dart';
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
  GeoPosition? cityPosition;
  WeatherApiResponse? weatherApiResponse;
  List<String> cities = [];

  // List<String> cities = ["Paris", "Nice", "Marseille"];

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
        body: Column(children: [
          AddCityView(onAddCity: onAddCity),
          Expanded(
            child: ForcastView(weatherApiResponse: weatherApiResponse),
          )
        ]),
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

    onAddCity(currentResponses.city.name);
  }

  updateWeatherInfos() async {
    if (cityPosition == null) return;
    weatherApiResponse =
        await WeatherApiService().callWeatherApi(cityPosition!);
    setState(() {});
  }

  onMenuItemTap(String s) async {
    debugPrint("onTap: $s");
    Navigator.of(context).pop();
    if (s == userPosition!.city) {
      cityPosition = userPosition;
      updateWeatherInfos();
    } else {
      cityPosition = await LocationService().getCoordsFromCity(s);
      updateWeatherInfos();
    }
  }

  onAddCity(String s) {
    debugPrint("onTap: $s");
    DataPersistence().addCity(s).then((value) => updateCities());
  }

  updateCities() async {
    cities = await DataPersistence().getCities();
    setState(() {});
  }
}
