import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:advanced_weather_app/features/models/weekly_weather_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InfoWeatherWeeklyPerDay extends StatelessWidget {
  final WeeklyWeatherModel weather;
  const InfoWeatherWeeklyPerDay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // date of Day
          Text(
            DateFormat("dd/MM").format(weather.date),
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
          // Icon weather
          Icon(
            weatherController.getIconType(weather.condition),
            size: 32,
            color: Colors.white,
          ),
          // Max Temp
          Text(
            "${weather.maxTempC}°C max",
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
          // min Temp
          Text(
            "${weather.minTempC}°C min",
            style: TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
