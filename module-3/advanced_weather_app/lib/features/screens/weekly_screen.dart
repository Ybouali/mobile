import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';

class WeeklyScreen extends StatelessWidget {
  final String text;
  const WeeklyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: CustomAppBar(onGeo: () => weatherController.getCurrentLocation()),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  Text(weatherController.city.value),
                  Text(weatherController.state.value),
                  Text(weatherController.country.value),

                  if (weatherController.weatherWeek.value != null &&
                      weatherController.weatherWeek.value!.isNotEmpty)
                    ...weatherController.weatherWeek.value!.map((wWeather) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(wWeather.date),
                            ),
                            Text('${wWeather.minTempC.toString()} °C'),
                            Text("${wWeather.maxTempC.toString()} °C"),
                            Text(wWeather.description),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
