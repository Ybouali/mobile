import 'package:advanced_diary_app/features/components/feel_card.dart';
import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/features/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastSevenEntry extends StatelessWidget {
  const LastSevenEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    return Container(
      padding: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
      margin: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            "Your feel for your 7 entries",
            style: TextStyle(
              fontFamily: "Tangerine",
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Obx(() {
            if (entryController.entryList.isEmpty) {
              return Center(
                child: Text(
                  "No Entry ! Try to add one .",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.only(left: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: entryController.entryList.length,
                  itemBuilder: (context, index) {
                    if (index >= 7) {
                      return null;
                    }

                    final EntryModel entry = entryController.entryList[index];
                    return FeelCard(
                      percent: entry.percent,
                      icon: entryController.feelingIcons[entry.feeling]!,
                      colorIcon: entryController.feelingColors[entry.feeling]!,
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
