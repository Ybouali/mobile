import 'package:diary_app/features/components/entry_card.dart';
import 'package:diary_app/features/components/new_entry_button.dart';
import 'package:diary_app/features/controllers/entry_controller.dart';
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
      body: SafeArea(
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
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return EntryCard(
                            onTap: () => _showMoreInfoOfFeeling(
                              context,
                              entryController,
                            ),
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
      ),
    );
  }
}

void _showMoreInfoOfFeeling(
  BuildContext context,
  EntryController entryController,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        'Thursday, March 16, 2025',
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
              onPressed: () {
                Navigator.of(context).pop();
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
                    color: entryController.feelingColors[currentFeeling.value],
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
    ),
  );
}
