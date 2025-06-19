import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController navController = Get.put(EntryController());
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: Colors.blue,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Colors.grey.shade500,
          height: 80,
          elevation: 0,
          selectedIndex: navController.selectedIndex.value,
          onDestinationSelected: (value) =>
              navController.selectedIndex.value = value,
          destinations: [
            NavigationDestination(
              icon: Container(
                width: double.infinity,
                height: double.infinity,
                color: navController.selectedIndex.value == 0
                    ? Colors.blue
                    : Colors.grey.shade500,
                child: Icon(Icons.person, size: 32),
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Container(
                width: double.infinity,
                height: double.infinity,
                color: navController.selectedIndex.value == 1
                    ? Colors.blue
                    : Colors.grey.shade500,
                child: Icon(Icons.calendar_month, size: 32),
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (navController.selectedIndex.value == 0) {
          navController.getAllEntrybyEmail();
        } else {
          navController.getAllEntrybyEmailAndFixedTime(DateTime.now());
        }

        return navController.screens[navController.selectedIndex.value];
      }),
    );
  }
}
