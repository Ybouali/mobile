import 'package:diary_app/features/controllers/entry_controller.dart';
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
        onPressed: () => _addEntry(context, entryController),
        child: Text(
          "New diary entry",
          style: TextStyle(
            fontFamily: "Tangerine",
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

void _addEntry(BuildContext context, EntryController entryController) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        "Add an Entry",
        style: TextStyle(
          fontFamily: "Tangerine",
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Tangerine',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Tangerine',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                await entryController.createEntry();
                Get.back();
                entryController.contentController.clear();
                entryController.titleController.clear();
              },
            ),
          ],
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: entryController.titleController,
              decoration: InputDecoration(
                labelText: 'Add a title for your feeling !',
                labelStyle: TextStyle(
                  fontFamily: 'Tangerine',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              final currentFeeling = entryController.selectedFeelingOnCreated;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => entryController.prevFeeling(),
                    icon: Icon(Icons.arrow_left, size: 40),
                  ),
                  Icon(
                    entryController.feelingIcons[currentFeeling.value],
                    size: 32,
                    color: entryController.feelingColors[currentFeeling.value],
                  ),
                  IconButton(
                    onPressed: () => entryController.nextFeeling(),
                    icon: Icon(Icons.arrow_right, size: 40),
                  ),
                ],
              );
            }),

            const SizedBox(height: 10),

            TextField(
              controller: entryController.contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Add a content for your feeling !',
                labelStyle: TextStyle(
                  fontFamily: 'Tangerine',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
