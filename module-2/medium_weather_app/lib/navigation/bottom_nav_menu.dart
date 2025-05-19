import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final wheatherController = Get.put(WeatherController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex:
              wheatherController.selectedIndex.value > 2
                  ? 0
                  : wheatherController.selectedIndex.value,
          onDestinationSelected:
              (value) => wheatherController.selectedIndex.value = value,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Currently",
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today),
              label: "Today",
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: "Weekly",
            ),
          ],
        ),
      ),
      body: Obx(
        () => wheatherController.screen[wheatherController.selectedIndex.value],
      ),
    );
  }
}
