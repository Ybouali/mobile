import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';
import 'package:medium_weather_app/features/models/weather_model.dart';

class TodayScreen extends StatelessWidget {
  final String text;
  const TodayScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    final List<WeatherModel> weatherDay = [
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
      WeatherModel(
        tempC: 20.0,
        windKph: 9.0,
        date: DateTime.now().add(const Duration(hours: 12)),
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        onGeo: () => weatherController.getCurrentLoacation(),
      ),
      body: Center(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(weatherController.city.value),
                Text(weatherController.state.value),
                Text(weatherController.country.value),

                // return a Colum of rows of hour and tempC, windKph
                ...weatherDay.map((weather) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${weather.date.hour.toString().padLeft(2, '0')}:00',
                        ),
                        Text(weather.tempC.toString()),
                        Text(weather.windKph.toString()),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
