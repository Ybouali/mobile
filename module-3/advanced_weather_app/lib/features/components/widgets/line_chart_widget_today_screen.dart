import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LineChartWidgetTodayScreen extends StatelessWidget {
  LineChartWidgetTodayScreen({super.key});

  final weatherController = Get.put(WeatherController());

  List<FlSpot> getSpots() {
    List<FlSpot> sp = weatherController.weatherDay.value!.map((dWeather) {
      return FlSpot(
        double.parse(
          DateFormat("HH:mm").format(dWeather.date).toString().split(":")[0],
        ),
        dWeather.tempC,
      );
    }).toList();

    return sp;
  }

  String getTemperatureLabel(double value) {
    return '${value.toInt()}°C';
  }

  String getTimeLabel(double value) {
    final hour = value.toInt();
    return '${hour.toString().padLeft(2, '0')}:00';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LineChart(
        LineChartData(
          minX: 0,
          maxX: 23,
          minY: 0,
          maxY: 40,
          lineBarsData: [
            LineChartBarData(
              spots: getSpots(),
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.redAccent, Colors.amberAccent],
              ),
              barWidth: 4,
              isCurved: true,
              preventCurveOverShooting: true,
              isStrokeCapRound: true,
              // belowBarData: BarAreaData(show: true),
            ),
          ],
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 3,
                getTitlesWidget: (value, meta) {
                  return Text(
                    getTimeLabel(value),
                    style: TextStyle(fontSize: 10, color: Colors.amber[50]),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    getTemperatureLabel(value),
                    style: TextStyle(fontSize: 10, color: Colors.amber[50]),
                  );
                },
              ),
            ),

            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}
