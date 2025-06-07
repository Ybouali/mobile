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

    IconData iconType() {
      final String con = weatherController.getAnimationForCurrentWeather(
        weather.condition,
      );

      final String getJsonCon = con.split("/").last;

      final List<String> listSplit = getJsonCon.split(".");

      final String getcon = listSplit[listSplit.length - 2];

      if (getcon == "sunny") {
        return Icons.wb_sunny_outlined;
      } else if (getcon == "rain") {
        return Icons.grain_outlined;
      } else if (getcon == "snow") {
        return Icons.ac_unit;
      } else if (getcon == "cloud") {
        return Icons.cloud;
      }

      return Icons.wb_sunny_outlined;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          Icon(iconType(), size: 32, color: Colors.white),
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
