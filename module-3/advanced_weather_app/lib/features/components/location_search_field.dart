import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSearchField extends StatelessWidget {
  final weatherController = Get.put(WeatherController());
  LocationSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: weatherController.textFieldController,
      cursorColor: Colors.white,
      cursorHeight: 16,
      cursorWidth: 1,
      style: TextStyle(color: Colors.white70, fontSize: 16),
      decoration: const InputDecoration(
        labelText: 'Search Location',
        labelStyle: TextStyle(color: Colors.blueGrey),
        contentPadding: EdgeInsets.all(2),
        border: InputBorder.none,
      ),
      onChanged: (value) async {
        weatherController.textFieldController.text = value;
        await weatherController.fetchCitySuggestions();
      },
    );
  }
}
