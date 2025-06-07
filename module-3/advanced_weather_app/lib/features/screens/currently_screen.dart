import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:lottie/lottie.dart';

class CurrentlyScreen extends StatelessWidget {
  final String text;
  const CurrentlyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        onGeo: () async => await weatherController.getCurrentLocation(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            if (weatherController.curr.value != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      weatherController.city.value,
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${weatherController.state.value}, ${weatherController.country.value}",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      '${weatherController.curr.value?.tempC.toString()} °C',
                      style: TextStyle(color: Colors.amber, fontSize: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      weatherController.curr.value!.condition,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset(
                      weatherController.getAnimationForCurrentWeather(
                        weatherController.curr.value!.condition,
                      ),
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.air, color: Colors.white, size: 32),
                        const SizedBox(width: 10),
                        Text(
                          '${weatherController.curr.value?.windKph.toString()} Km/h',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                "No Data",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }),
        ),
      ),
    );
  }
}
