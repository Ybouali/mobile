import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/controller/weather_controller.dart';

class CurrentlyScreen extends StatelessWidget {
  final String text;
  const CurrentlyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final wheatherController = Get.put(WeatherController());

    return Center(
      child: Obx(
        () => Text(
          '$text\n${wheatherController.searchedText.value}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
