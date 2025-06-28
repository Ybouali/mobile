import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/custom_app_bar.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        weatherController.showSearchButton.value = true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onPress: () async {
            if (weatherController.textFieldController.text.isNotEmpty) {
              await weatherController.getTheWeatherAndSetTheValues();
            }
          },
          onGeo: () async => await weatherController.getCurrentLocation(),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex:
                weatherController.selectedIndex.value > 2
                    ? 0
                    : weatherController.selectedIndex.value,
            onDestinationSelected: (value) async {
              weatherController.selectedIndex.value = value;
              await weatherController.getTheWeatherAndSetTheValues();
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
      ),
    );
  }
}
