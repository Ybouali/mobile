import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
      location.value =
          'Lat: ${position.latitude} and Log: ${position.longitude}';
      searchedText.value = location.value;
    } catch (e) {
      selectedIndex.value = 3;
      Get.offAll(() => BottomNavMenu());
    }
  }
}
