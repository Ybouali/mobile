import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/components/custom_app_bar.dart';
import 'package:weather_app/features/controller/weather_controller.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return Scaffold(
      appBar: CustomAppBar(
        onSearch: () => weatherController.onSearch(),
        onGeo: () => weatherController.geoLocation(),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: weatherController.selectedIndex.value,
          onDestinationSelected: (value) {
            weatherController.textFieldController.clear();
            // weatherController.searchedText. = "";
            weatherController.selectedIndex.value = value;
          },
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
        () => weatherController.screen[weatherController.selectedIndex.value],
      ),
    );
  }
}
