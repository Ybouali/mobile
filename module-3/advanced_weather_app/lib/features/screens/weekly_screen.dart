import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';

class WeeklyScreen extends StatelessWidget {
  final String text;
  const WeeklyScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(onGeo: () => weatherController.getCurrentLocation()),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
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
                  const SizedBox(height: 20),

                  // Expanded(
                  //   child: SizedBox(
                  //     height: 250,
                  //     width: 500,
                  //     child: LineChartWidgetWeeklyScreen(),
                  //   ),
                  // ),

                  // if (weatherController.weatherWeek.value != null &&
                  //     weatherController.weatherWeek.value!.isNotEmpty)
                  //   ...weatherController.weatherWeek.value!.map((wWeather) {
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             DateFormat('yyyy-MM-dd').format(wWeather.date),
                  //           ),
                  //           Text('${wWeather.minTempC.toString()} °C'),
                  //           Text("${wWeather.maxTempC.toString()} °C"),
                  //           Text(wWeather.description),
                  //         ],
                  //       ),
                  //     );
                  //   }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
