import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/models/entry_model.dart';
import 'package:diary_app/utils/entry_utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryCard extends StatelessWidget {
  final VoidCallback? onTap;
  final EntryModel entry;

  const EntryCard({super.key, this.onTap, required this.entry});

  @override
  Widget build(BuildContext context) {
    final (year, day) = EntryUtilsFunctions().getYearAndDay(entry.date!);
    final EntryController entryController = Get.put(EntryController());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  day,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  EntryUtilsFunctions().getNameOfMonth(entry.date!),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  year,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Emojie
                Icon(
                  entryController.feelingIcons[entry.feeling],
                  size: 32,
                  color: entryController.feelingColors[entry.feeling],
                ),
                const SizedBox(width: 20),
                // Divider
                Container(height: 60, width: 2, color: Colors.black),

                const SizedBox(width: 20),

                // Tille
                SizedBox(
                  width: 100,
                  child: Text(
                    entry.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
