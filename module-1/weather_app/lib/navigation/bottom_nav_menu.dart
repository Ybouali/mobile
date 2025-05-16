import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/components/custom_app_bar.dart';
import 'package:weather_app/features/screens/currently_screen.dart';
import 'package:weather_app/features/screens/today_screen.dart';
import 'package:weather_app/features/screens/weekly_screen.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (value) => controller.selectedIndex.value = value,
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
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screen = [
    CurrentlyScreen(text: "Current"),
    TodayScreen(text: "Today"),
    WeeklyScreen(text: "Weekly"),
  ];
}
