import 'package:diary_app/features/components/entry_card.dart';
import 'package:diary_app/features/screens/list_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastTwoEntry extends StatelessWidget {
  const LastTwoEntry({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Text(
              "Your last diary entries",
              style: TextStyle(
                fontFamily: "Tangerine",
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            EntryCard(onTap: null),

            EntryCard(onTap: null),
          ],
        ),
      ),
    );
  }
}
