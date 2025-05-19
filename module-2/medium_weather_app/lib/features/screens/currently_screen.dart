import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class CurrentlyScreen extends StatelessWidget {
  final String text;
  const CurrentlyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final wheatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: CustomAppBar(
        onSearch: () => wheatherController.onSearch(),
        onGeo: () => wheatherController.getCurrentLoacation(),
      ),
      body: Center(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$text\n${wheatherController.searchedText.value}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
