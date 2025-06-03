import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';

class GeolocatorDeniedPermissionScreen extends StatelessWidget {
  const GeolocatorDeniedPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        onGeo: () async => await weatherController.getCurrentLocation(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => Text(
              weatherController
                  .errorStrings
                  .value[weatherController.errorNumber.value]
                  .toString(),
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
