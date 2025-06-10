import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LineChartWidgetWeeklyScreen extends StatefulWidget {
  const LineChartWidgetWeeklyScreen({super.key});

  @override
  State<LineChartWidgetWeeklyScreen> createState() =>
      _LineChartWidgetWeeklyScreenState();
}

class _LineChartWidgetWeeklyScreenState
    extends State<LineChartWidgetWeeklyScreen> {
  List<String> _dates = [];
  late WeatherController weatherController;

  List<String> getDateList() {
    DateTime today = DateTime.now();
    final DateTime endDate = DateTime.now().add(const Duration(days: 7));

    final List<DateTime> dates = [];
    while (today.isBefore(endDate) || today.isAtSameMomentAs(endDate)) {
      dates.add(today);
      today = today.add(const Duration(days: 1));
    }

    List<String> newDates = dates.map((d) {
      DateTime date = DateTime.parse(d.toString());
      String formatedDate = DateFormat('dd/MM').format(date);
      return formatedDate;
    }).toList();
    return newDates;
  }

  @override
  void initState() {
    super.initState();
    _dates = getDateList();
    weatherController = Get.put(WeatherController());
  }

  String getTemperatureLabel(double value) {
    return '${value.toInt()}°C';
  }

  List<FlSpot> getSpotMax() {
    if (weatherController.weatherWeek.value == null) {
      return [];
    }
    List<FlSpot> maxSp = weatherController.weatherWeek.value!
        .asMap()
        .entries
        .map((w) {
          return FlSpot(w.key.toDouble(), w.value.maxTempC);
        })
        .toList();
    return maxSp;
  }

  List<FlSpot> getSpotMin() {
    if (weatherController.weatherWeek.value == null) {
      return [];
    }
    List<FlSpot> maxSp = weatherController.weatherWeek.value!
        .asMap()
        .entries
        .map((w) {
          return FlSpot(w.key.toDouble(), w.value.minTempC);
        })
        .toList();
    return maxSp;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 40,
        minX: 0,
        maxX: 7,
        lineBarsData: [
          // max temp
          LineChartBarData(
            spots: getSpotMax(),
            color: Colors.blueAccent,
            barWidth: 2,
            isCurved: true,
            preventCurveOverShooting: true,
            isStrokeCapRound: true,
          ),
          // min temp
          LineChartBarData(
            spots: getSpotMin(),
            color: Colors.redAccent,
            barWidth: 2,
            isCurved: true,
            preventCurveOverShooting: true,
            isStrokeCapRound: true,
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  _dates[value.toInt()],
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
          rightTitles: AxisTitles(),
          topTitles: AxisTitles(),
        ),
      ),
    );
  }
}
