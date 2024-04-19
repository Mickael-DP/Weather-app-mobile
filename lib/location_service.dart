import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart'
    as geocoding; // alias nécessaire car symboles aussi definis dans 'location'
import 'package:live_weather_api_demo/geo_position.dart';
import 'package:location/location.dart';

class LocationService {
  // Get user location
  Future<LocationData?> getPosition() async {
    try {
      Location location = Location();
      return location.getLocation();
    } on PlatformException catch (error) {
      debugPrint("unable to get location : ${error.message}");
      return null;
    }
  }

  // convert (lat,lon) -> city name
  Future<GeoPosition?> getCity() async {
    final LocationData? position = await getPosition();
    final double lat = position?.latitude ?? 0;
    final double lon = position?.longitude ?? 0;

    List<geocoding.Placemark> placemark =
        await geocoding.placemarkFromCoordinates(lat, lon);
    debugPrint(placemark.toString());
    final firstPlace = placemark.first;
    return GeoPosition(city: firstPlace.locality ?? "", lat: lat, lon: lon);
  }

  // convert city name -> (lat,lon)
  Future<GeoPosition?> getCoordsFromCity(String city) async {
    List<geocoding.Location> locations =
        await geocoding.locationFromAddress(city);
    final location = locations.first;
    return GeoPosition(
        city: city, lat: location.latitude, lon: location.longitude);
  }

  getLocation() {}
}
