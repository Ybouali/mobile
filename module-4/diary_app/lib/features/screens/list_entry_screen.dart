import 'package:diary_app/features/components/entry_card.dart';
import 'package:diary_app/features/components/new_entry_button.dart';
import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/models/entry_model.dart';
import 'package:diary_app/utils/entry_utils_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListEntryScreen extends StatelessWidget {
  const ListEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, size: 32),
        ),
      ),
      body: Obx(() {
        if (entryController.entryList.isEmpty) {
          return Center(
            child: Text(
              "NO ENTRY, Add one ",
              style: TextStyle(
                fontFamily: "Tangerine",
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          );
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
                  margin: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 114, 190, 118),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your last diary entries",
                        style: TextStyle(
                          fontFamily: "Tangerine",
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: entryController.entryList.length,
                          itemBuilder: (context, index) {
                            final EntryModel entryModel =
                                entryController.entryList[index];
                            print(entryModel.date);
                            return EntryCard(
                              onTap: () => _showMoreInfoOfFeeling(
                                context,
                                entryController,
                                entryModel,
                              ),
                              entry: entryModel,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NewEntryButton(),
            ],
          ),
        );
      }),
    );
  }
}

void _showMoreInfoOfFeeling(
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

      final (year, day) = EntryUtilsFunctions().getYearAndDay(entryModel.date!);

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
              Obx(() {
                final currentFeeling = entryController.selectedFeelingOnCreated;
                return Row(
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
                      entryController.feelingIcons[currentFeeling.value],
                      size: 40,
                      color:
                          entryController.feelingColors[currentFeeling.value],
                    ),
                  ],
                );
              }),
              Divider(color: Colors.black),
              SizedBox(height: 10),
              Text(
                "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
