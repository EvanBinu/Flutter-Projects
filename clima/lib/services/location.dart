import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location{
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async{
    try {
      if (await Geolocator.requestPermission() == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print("Error: $e");
    }
  }
}