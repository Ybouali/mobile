import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidgetWeeklyScreen extends StatelessWidget {
  const LineChartWidgetWeeklyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<DateTime>

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 40,
        minX: 0,
        maxX: 7,
        lineBarsData: [],
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  "",
                  style: TextStyle(fontSize: 10, color: Colors.amber[50]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
