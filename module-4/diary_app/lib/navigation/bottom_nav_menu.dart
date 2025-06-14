import 'package:diary_app/features/components/background.dart';
import 'package:diary_app/features/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: navController.selectedIndex.value,
        onDestinationSelected: (value) =>
            navController.selectedIndex.value = value,
        destinations: [
          NavigationDestination(icon: Icon(Icons.person), label: ''),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: ''),
        ],
      ),
      body: Background(
        child: Obx(
          () => navController.screens[navController.selectedIndex.value],
        ),
      ),
    );
  }
}
