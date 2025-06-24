import 'package:advanced_weather_app/features/components/info_weather_weekly_per_day.dart';
import 'package:advanced_weather_app/features/components/widgets/line_chart_widget_weekly_screen.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:advanced_weather_app/features/models/weekly_weather_model.dart';
import 'package:advanced_weather_app/features/screens/widgets/error_new_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/components/custom_app_bar.dart';

class WeeklyScreen extends StatelessWidget {
  final String text;
  const WeeklyScreen({super.key, required this.text});

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
            if (weatherController.errorNumber.value != 0) {
              return ErrorNewWidget(
                error: weatherController
                    .errorStrings
                    .value[weatherController.errorNumber.value]
                    .toString(),
              );
            }

            if (weatherController.weatherWeek.value != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
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

                    Container(
                      // height: 300,
                      width: 500,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(95, 187, 233, 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Weekly temperatures",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 250,
                            width: 500,
                            child: LineChartWidgetWeeklyScreen(),
                          ),
                          // info of bars of the line chart
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.linear_scale_sharp,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Min temperatures",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.linear_scale_sharp,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Max temperatures",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
                              weatherController.weatherWeek.value?.length ?? 0,
                          itemBuilder: (context, index) {
                            if (weatherController.weatherWeek.value != null) {
                              final WeeklyWeatherModel weather =
                                  weatherController.weatherWeek.value![index];
                              return InfoWeatherWeeklyPerDay(weather: weather);
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
