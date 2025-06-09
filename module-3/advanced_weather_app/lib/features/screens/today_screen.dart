import 'package:advanced_weather_app/features/components/info_weather_day_by_hour.dart';
import 'package:advanced_weather_app/features/components/widgets/line_chart_widget_today_screen.dart';
import 'package:advanced_weather_app/features/models/weather_model.dart';
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
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(onGeo: () => weatherController.getCurrentLocation()),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            if (weatherController.curr.value != null) {
              return Padding(
                padding: const EdgeInsets.all(8),
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

                    // Line Chart
                    Container(
                      height: 300,
                      width: 500,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(95, 187, 233, 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Today temperatures",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SizedBox(
                              height: 250,
                              width: 500,
                              child: LineChartWidgetTodayScreen(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // more info weather of a day
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(95, 187, 233, 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: RawScrollbar(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(),
                        trackRadius: const Radius.circular(10),
                        radius: const Radius.circular(10),
                        trackVisibility: true,
                        thumbColor: Colors.amber,
                        thumbVisibility: true,
                        interactive: true,
                        child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              weatherController.weatherDay.value?.length ?? 0,
                          itemBuilder: (context, index) {
                            if (weatherController.weatherDay.value != null) {
                              final WeatherModel weather =
                                  weatherController.weatherDay.value![index];

                              return InfoWeatherDayByHour(weather: weather);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(
                "No Data",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }),
        ),
      ),
    );
  }
}
