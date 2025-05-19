import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class TodayScreen extends StatelessWidget {
  final String text;
  const TodayScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final wheatherController = Get.put(WeatherController());
    final String city = wheatherController.textFieldController.text;

    return Scaffold(
      appBar: CustomAppBar(
        onSearch: () => wheatherController.onSearch(),
        onGeo: () {},
      ),
      body: Center(
        child: Text(
          '$text\n$city',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
