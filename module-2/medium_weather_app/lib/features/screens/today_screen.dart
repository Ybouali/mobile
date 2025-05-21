import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class TodayScreen extends StatelessWidget {
  final String text;
  const TodayScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: CustomAppBar(
        onGeo: () => weatherController.getCurrentLoacation(),
      ),
      body: Center(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '$text\n${weatherController.searchedText.value}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
