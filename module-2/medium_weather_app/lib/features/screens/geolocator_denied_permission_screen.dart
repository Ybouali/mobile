import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class GeolocatorDeniedPermissionScreen extends StatelessWidget {
  final String errorText;

  const GeolocatorDeniedPermissionScreen({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: CustomAppBar(
        onGeo: () => weatherController.getCurrentLoacation(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(errorText, style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
