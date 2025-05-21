import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final RxBool searchIsLoading = false.obs;
  final RxString location = ''.obs;

  final RxInt numberTimeCallReq = 0.obs;
  final RxBool showSearchButton = true.obs;
  final RxDouble currentLatitude = 0.0.obs;
  final RxDouble currentLongitude = 0.0.obs;

  @override
  void onInit() {
    screen = [
      CurrentlyScreen(text: "Current"),
      TodayScreen(text: "Today"),
      WeeklyScreen(text: "Weekly"),
      GeolocatorDeniedPermissionScreen(
        errorText:
            'Geolocation is not available, please enable it in your app settings !',
      ),
    ];

    Future.delayed(Duration.zero, () async {
      await getCurrentLoacation();
    });

    super.onInit();
  }

  void onSearch() {
    searchedText.value = textFieldController.text;
    showSearchButton.value = false;
    // textFieldController.clear();
    // print("FROM onSearch");
    // print(searchedText.value);
    // print("DONE onSearch");
    getLanAndLongFromName();
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

      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;

      // print("FROM getCurrentLoacation");
      // print(currentLatitude.value);
      // print(currentLongitude.value);
      // print("DONE getCurrentLoacation");
      getNameFromPosition();
    } catch (e) {
      selectedIndex.value = 3;
      Get.offAll(() => BottomNavMenu());
    }
  }

  void getNameFromPosition() async {
    // print("FROM getNameFromPosition");
    // print(currentLatitude.value);
    // print(currentLongitude.value);
    // print("DONE getNameFromPosition");
    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLatitude.value,
      currentLatitude.value,
    );
    Placemark place = placemarks[0];
    location.value =
        '${place.locality}, ${place.administrativeArea}, ${place.country}';
    // print("location.value");
    // print(location.value);
    searchedText.value = location.value;
    textFieldController.text = location.value;
  }

  void getLanAndLongFromName() async {
    // print("------------- start  ---------");
    // print(searchedText.value);
    List<Location> locations = await locationFromAddress(searchedText.value);

    Location loc = locations.first;
    currentLatitude.value = loc.latitude;
    currentLongitude.value = loc.latitude;
    // print("currentLatitude.value");
    // print(currentLatitude.value);
    getNameFromPosition();
  }

  Future<List<String>> fetchCitySuggestions() async {
    if (textFieldController.text.isEmpty) {
      return [];
    }

    final apiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];

    const String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    final response = await http.get(
      Uri.parse(
        '$baseUrl?input=${textFieldController.text}&types=(cities)&key=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final predictions = data['predictions'] as List;
      return predictions.map((p) {
        return p['description'] as String;
      }).toList();
    } else {
      throw Exception("Failed to fetch suggestions");
    }
  }

  void getCurrentWeather() async {
    final apiKeyWeather = dotenv.env['WEATHER_API_KEY'];

    final String url =
        "https://api.openweathermap.org/data/3.0/onecall?lat=${currentLatitude.value}&lon=${currentLongitude.value}&exclude=current,daily&appid=$apiKeyWeather";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      // print(jsonDecode(res.body));
    } else {
      throw Exception("Failed to fetch weather curr");
    }
  }
}
