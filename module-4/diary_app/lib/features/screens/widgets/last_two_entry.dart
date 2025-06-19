import 'package:diary_app/features/components/entry_card.dart';
import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/screens/list_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastTwoEntry extends StatelessWidget {
  const LastTwoEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    return GestureDetector(
      onTap: () => Get.to(() => ListEntryScreen()),
      child: Container(
        padding: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
        margin: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Obx(() {
          if (entryController.entryList.isEmpty) {
            return Center(
              child: Text(
                "No Entry ! Try to add one .",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            );
          }
          return Column(
            children: [
              Text(
                "Your last diary entries",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),

              if (entryController.entryList.isNotEmpty)
                EntryCard(onTap: null, entry: entryController.entryList[0]),

              if (entryController.entryList.length >= 2)
                EntryCard(onTap: null, entry: entryController.entryList[1]),
            ],
          );
        }),
      ),
    );
  }
}
