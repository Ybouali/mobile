import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController navController = Get.put(EntryController());
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.grey.shade500,
        height: 80,
        elevation: 0,
        selectedIndex: navController.selectedIndex.value,
        onDestinationSelected: (value) =>
            navController.selectedIndex.value = value,
        destinations: [
          NavigationDestination(icon: Icon(Icons.person, size: 32), label: ''),
          NavigationDestination(
            icon: Icon(Icons.calendar_month, size: 32),
            label: '',
          ),
        ],
      ),
      body: Obx(() => navController.screens[navController.selectedIndex.value]),
    );
  }
}
