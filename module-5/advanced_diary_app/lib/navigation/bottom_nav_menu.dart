import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavMenu extends StatelessWidget {
  const BottomNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.grey.shade500,
        height: 80,
        elevation: 0,
        selectedIndex: entryController.selectedIndex.value,
        onDestinationSelected: (value) =>
            entryController.selectedIndex.value = value,
        destinations: [
          NavigationDestination(icon: Icon(Icons.person, size: 32), label: ''),
          NavigationDestination(
            icon: Icon(Icons.calendar_month, size: 32),
            label: '',
          ),
        ],
      ),
      body: Obx(() {
        if (entryController.selectedIndex.value == 0) {
          entryController.getAllEntrybyEmail();
        }

        return entryController.screens[entryController.selectedIndex.value];
      }),
    );
  }
}
