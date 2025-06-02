import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';

class TodayScreen extends StatelessWidget {
  final String text;
  const TodayScreen({super.key, required this.text});

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

                  // return a Colum of rows of hour and tempC, windKph
                  if (weatherController.weatherDay.value != null &&
                      weatherController.weatherDay.value!.isNotEmpty)
                    ...weatherController.weatherDay.value!.map((weather) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${weather.date.hour.toString().padLeft(2, '0')}:00',
                            ),
                            Text('${weather.tempC.toString()} °C'),
                            Text("${weather.windKph.toString()} Km/h"),
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
