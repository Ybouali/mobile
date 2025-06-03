import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: CustomAppBar(
        onGeo: () async => await weatherController.getCurrentLocation(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Lottie.asset("assets/animations/error/error_animation.json"),
              Obx(
                () => Text(
                  weatherController
                      .errorStrings
                      .value[weatherController.errorNumber.value]
                      .toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
