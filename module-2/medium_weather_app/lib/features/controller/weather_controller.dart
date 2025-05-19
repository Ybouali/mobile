import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medium_weather_app/features/screens/currently_screen.dart';
import 'package:medium_weather_app/features/screens/geolocator_denied_permission_screen.dart';
import 'package:medium_weather_app/features/screens/today_screen.dart';
import 'package:medium_weather_app/features/screens/weekly_screen.dart';
import 'package:medium_weather_app/navigation/bottom_nav_menu.dart';

class WeatherController extends GetxController {
  static WeatherController get instance => Get.find();

  // Variables
  final TextEditingController textFieldController = TextEditingController();
  final RxInt selectedIndex = 0.obs;
  final RxString searchedText = ''.obs;
  late List<Widget> screen;
  final RxString location = ''.obs;
  final RxInt numberTimeCallReq = 0.obs;

  @override
  void onInit() {
    screen = [
      CurrentlyScreen(text: "Current"),
      TodayScreen(text: "Today"),
      WeeklyScreen(text: "Weekly"),
      GeolocatorDeniedPermissionScreen(),
    ];

    Future.delayed(Duration.zero, () async {
      await getCurrentLoacation();
    });

    super.onInit();
  }

  void onSearch() {
    searchedText.value = textFieldController.text;
    textFieldController.clear();
    _getLanAndLongFromName();
  }

  Future<void> getCurrentLoacation() async {
    try {
      numberTimeCallReq.value += 1;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        selectedIndex.value = 3;
        Get.offAll(() => BottomNavMenu());
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          selectedIndex.value = 3;
          Get.offAll(() => BottomNavMenu());
          return;
        }
      }

      if (permission == LocationPermission.deniedForever &&
          numberTimeCallReq.value == 2) {
        numberTimeCallReq.value = 1;
        Get.defaultDialog(
          title: "Permission Required",
          content: const Text(
            "Location permission is permanently denied. Please enable it in the app settings.",
          ),
          confirm: ElevatedButton(
            onPressed: () {
              AppSettings.openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
          cancel: TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
        );

        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      _getNameFromPosition(position.latitude, position.longitude);
    } catch (e) {
      selectedIndex.value = 3;
      Get.offAll(() => BottomNavMenu());
    }
  }

  void _getNameFromPosition(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    location.value =
        '${place.locality}, ${place.administrativeArea}, ${place.country}';
    searchedText.value = location.value;
    textFieldController.text = location.value;
  }

  void _getLanAndLongFromName() async {
    List<Location> locations = await locationFromAddress(searchedText.value);
    Location loc = locations.first;
    _getNameFromPosition(loc.latitude, loc.longitude);
  }

  Future<List<String>> fetchCitySuggestions() async {
    const apiKey = "AIzaSyDG35htYa1vR1C32X2hzlV7nn5IPMGNUoI";

    final String baseUrl =
        'https://places.googleapis.com/v1/places:autocomplete';

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'places.displayName',
      },
      body: jsonEncode({
        "input": textFieldController.text,
        "languageCode": "en",
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final predictions = data['predictions'] as List;
      return predictions.map((p) => p['description'] as String).toList();
    } else {
      throw Exception("Failed to fetch suggestions");
    }
  }
}
