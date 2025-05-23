import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class CurrentlyScreen extends StatelessWidget {
  final String text;
  const CurrentlyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: CustomAppBar(
        onGeo: () => weatherController.getCurrentLoacation(),
      ),
      body: Center(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(weatherController.city.value),
                Text(weatherController.state.value),
                Text(weatherController.country.value),
                if (weatherController.curr.value != null)
                  Text('${weatherController.curr.value?.tempC.toString()} °C'),
                if (weatherController.curr.value != null)
                  Text(
                    '${weatherController.curr.value?.windKph.toString()} Km/h',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
