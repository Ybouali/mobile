import 'package:advanced_weather_app/features/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        weatherController.suggestionList.value = [];
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Obx(
          () => Theme(
            data: Theme.of(context).copyWith(
              navigationBarTheme: NavigationBarThemeData(
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return TextStyle(color: Colors.amberAccent);
                  }
                  return TextStyle(color: Colors.white70);
                }),
              ),
            ),
            child: NavigationBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              height: 80,
              elevation: 0,
              selectedIndex: weatherController.selectedIndex.value > 2
                  ? 0
                  : weatherController.selectedIndex.value,
              onDestinationSelected: (value) async {
                weatherController.selectedIndex.value = value;
                await weatherController.getTheWeatherAndSetTheValues();
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.settings,
                    color: weatherController.selectedIndex.value == 0
                        ? Colors.amberAccent
                        : Colors.white70,
                  ),
                  label: "Currently",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.calendar_today,
                    color: weatherController.selectedIndex.value == 1
                        ? Colors.amberAccent
                        : Colors.white70,
                  ),
                  label: "Today",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.calendar_month,
                    color: weatherController.selectedIndex.value == 2
                        ? Colors.amberAccent
                        : Colors.white70,
                  ),
                  label: "Weekly",
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background_weather_app.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Obx(() {
              if (weatherController.suggestionList.value.isNotEmpty) {
                return Positioned(child: SearchScreen());
              } else {
                return weatherController.screen[weatherController
                    .selectedIndex
                    .value];
              }
            }),
          ],
        ),
      ),
    );
  }
}
