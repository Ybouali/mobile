import 'package:advanced_diary_app/features/components/entry_card.dart';
import 'package:advanced_diary_app/features/components/new_entry_button.dart';
import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/features/models/entry_model.dart';
import 'package:advanced_diary_app/utils/entry_poup_help.dart';
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
            Obx(() {
              if (entryController.entryList.isEmpty) {
                return Center(
                  child: Text(
                    "No entry !, Try to add one !",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                );
              }

              return Expanded(
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

                            return EntryCard(
                              onTap: () =>
                                  EntryPoupHelp().showMoreInfoOfFeeling(
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
              );
            }),
            NewEntryButton(),
          ],
        ),
      ),
    );
  }
}
