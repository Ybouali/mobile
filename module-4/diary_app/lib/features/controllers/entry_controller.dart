import 'package:diary_app/features/models/entry_model.dart';
import 'package:diary_app/features/screens/entry_screen.dart';
import 'package:diary_app/features/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EntryController extends GetxController {
  static EntryController get instance => Get.find();

  final List<Widget> screens = [ProfileScreen(), EntryScreen()];
  final RxInt selectedIndex = 0.obs;
  final Rx<Feeling> selectedFeelingOnCreated = Feeling.happy.obs;
  final Map<Feeling, IconData> feelingIcons = {
    Feeling.happy: Iconsax.emoji_happy,
    Feeling.sad: Iconsax.emoji_sad,
    Feeling.angry: Iconsax.emoji_sad,
    Feeling.anxious: Iconsax.emoji_normal,
    Feeling.excited: Iconsax.emoji_happy,
    Feeling.tired: Iconsax.emoji_sad,
    Feeling.neutral: Iconsax.emoji_normal,
    Feeling.grateful: Iconsax.lovely,
  };

  final Map<Feeling, Color> feelingColors = {
    Feeling.happy: Colors.yellow[600]!,
    Feeling.sad: Colors.blue[400]!,
    Feeling.angry: Colors.red[600]!,
    Feeling.anxious: Colors.purple[400]!,
    Feeling.excited: Colors.orange[600]!,
    Feeling.tired: Colors.blueGrey[400]!,
    Feeling.neutral: Colors.grey[600]!,
    Feeling.grateful: Colors.green[600]!,
  };

  void nextFeeling() {
    final feeling = Feeling.values;
    final nextFeeling =
        (selectedFeelingOnCreated.value.index + 1) % feeling.length;
    selectedFeelingOnCreated.value = feeling[nextFeeling];
  }

  void prevFeeling() {
    final feeling = Feeling.values;
    final prevFeeling =
        (selectedFeelingOnCreated.value.index - 1) % feeling.length;
    selectedFeelingOnCreated.value = feeling[prevFeeling];
  }
}
