import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:advanced_weather_app/features/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoWeatherDayByHour extends StatelessWidget {
  final WeatherModel weather;
  const InfoWeatherDayByHour({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = WeatherController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Hour
          Text(
            DateFormat("HH:mm").format(weather.date).toString(),
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
          // icon weather
          Icon(
            weatherController.getIconType(weather.condition),
            size: 32,
            color: Colors.white,
          ),
          // temp
          Text(
            "${weather.tempC.toString()} °C",
            style: TextStyle(color: Colors.amberAccent, fontSize: 20),
          ),
          // wind vitesse
          Row(
            children: [
              Icon(Icons.air, size: 25, color: Colors.white70),
              Text(
                "${weather.windKph.toString()} Km",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
