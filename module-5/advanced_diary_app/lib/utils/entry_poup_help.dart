import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/features/models/entry_model.dart';
import 'package:advanced_diary_app/utils/entry_utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryPoupHelp {
  void addEntry(BuildContext context, EntryController entryController) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Add an Entry",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                      color:
                          entryController.feelingColors[currentFeeling.value],
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

  void showMoreInfoOfFeeling(
    BuildContext context,
    EntryController entryController,
    EntryModel entryModel,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final String dString = EntryUtilsFunctions().getNameOfDay(
          entryModel.date!,
        );
        final String month = EntryUtilsFunctions().getNameOfMonth(
          entryModel.date!,
        );

        final (year, day) = EntryUtilsFunctions().getYearAndDay(
          entryModel.date!,
        );

        return AlertDialog(
          title: Text(
            "$dString, $month $day, $year ",
            style: TextStyle(
              fontFamily: 'Tangerine',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontFamily: 'Tangerine',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await entryController.deleteEntry(
                      entryModel.userEmail!,
                      entryModel.id!,
                    );
                    Get.back();
                  },
                ),
              ],
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(color: Colors.black),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "My Feeling : ",
                      style: TextStyle(
                        fontFamily: 'Tangerine',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      entryController.feelingIcons[entryModel.feeling],
                      size: 40,
                      color: entryController.feelingColors[entryModel.feeling],
                    ),
                  ],
                ),
                Divider(color: Colors.black),
                SizedBox(height: 5),
                Text(
                  entryModel.title,
                  style: TextStyle(
                    fontFamily: 'Tangerine',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  entryModel.content,
                  style: TextStyle(
                    fontFamily: 'Tangerine',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
