import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/screens/currently_screen.dart';
import 'package:weather_app/features/screens/today_screen.dart';
import 'package:weather_app/features/screens/weekly_screen.dart';

class WeatherController extends GetxController {
  static WeatherController get instance => Get.find();

  // Variables
  final TextEditingController textFieldController = TextEditingController();
  final RxInt selectedIndex = 0.obs;
  final RxString searchedText = ''.obs;
  late List<Widget> screen;

  @override
  void onInit() {
    screen = [
      CurrentlyScreen(text: "Current"),
      TodayScreen(text: "Today"),
      WeeklyScreen(text: "Weekly"),
    ];

    super.onInit();
  }

  void geoLocation() {
    searchedText.value = "Geolocation";
  }

  void onSearch() {
    searchedText.value = textFieldController.text;
    textFieldController.clear();
  }
}
