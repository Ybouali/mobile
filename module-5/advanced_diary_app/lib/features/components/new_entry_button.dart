import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/utils/entry_poup_help.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewEntryButton extends StatelessWidget {
  const NewEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(3),
          ),
          backgroundColor: Colors.green.shade400,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        ),
        onPressed: () => EntryPoupHelp().addEntry(context, entryController),
        child: Text(
          "New diary entry",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
