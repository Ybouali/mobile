import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:advanced_diary_app/features/models/entry_model.dart';
import 'package:advanced_diary_app/features/models/user_model.dart';
import 'package:advanced_diary_app/features/screens/entry_screen.dart';
import 'package:advanced_diary_app/features/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EntryController extends GetxController {
  static EntryController get instance => Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final List<Widget> screens = [ProfileScreen(), EntryScreen()];
  final RxInt selectedIndex = 0.obs;
  final Rx<UserModel?> user = UserModel.empty().obs;

  final Rx<Feeling> selectedFeelingOnCreated = Feeling.happy.obs;
  final RxList<EntryModel> entryList = <EntryModel>[].obs;
  final RxList<EntryModel> entryListByTime = <EntryModel>[].obs;

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

  @override
  void onInit() async {
    // await initUserIfIsOnStorage();
    await getAllEntrybyEmail();
    super.onInit();
  }

  Future<void> initUserIfIsOnStorage() async {
    final storage = FlutterSecureStorage();

    final String? email = await storage.read(key: "email");
    final String? name = await storage.read(key: "name");
    final String? expiresAt = await storage.read(key: "expiresAt");

    if (email != null &&
        name != null &&
        expiresAt != null &&
        email.isNotEmpty &&
        name.isNotEmpty &&
        expiresAt.isNotEmpty) {
      UserModel oldUser = UserModel(
        email: email,
        name: name,
        expiresAt: DateTime.parse(expiresAt),
      );
      user.value = UserModel.empty();
      if (oldUser.checkExp()) {
        user.value = oldUser;
      }
    }
  }

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

  Future<void> getAllEntrybyEmail() async {
    try {
      entryList.value = [];

      if (user.value!.email.isNotEmpty && user.value!.checkExp()) {
        final String useremail = user.value!.email;
        final snapshot = await _firebaseFirestore
            .collection("notes")
            .where("userEmail", isEqualTo: useremail)
            .orderBy('created_at', descending: true)
            .get();

        entryList.assignAll(
          snapshot.docs.map((doc) => EntryModel.fromFirestore(doc)).toList(),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getAllEntrybyEmailAndFixedTime(DateTime timestamp) async {
    await getAllEntrybyEmail();

    entryListByTime.value = [];
    entryListByTime.assignAll(
      entryList
          .where(
            (ent) =>
                ent.date!.year == timestamp.year &&
                ent.date!.month == timestamp.month &&
                ent.date!.day == timestamp.day,
          )
          .toList(),
    );
  }

  Future<void> deleteEntry(
    String userEmail,
    String entryId,
    DateTime? timestamp,
  ) async {
    try {
      if (user.value!.email == userEmail) {
        await _firebaseFirestore.collection("notes").doc(entryId).delete();
        Get.back();
        Get.snackbar(
          'Delete Entry',
          'Entry with title of $userEmail was deleted ! :)',
          snackPosition: SnackPosition.TOP,
          // duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        if (timestamp == null) {
          await getAllEntrybyEmail();
        } else {
          await getAllEntrybyEmailAndFixedTime(timestamp);
        }
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Delete Entry',
        'Could not delete the Entry with title of $userEmail !',
        snackPosition: SnackPosition.TOP,
      );
      debugPrint(e.toString());
    }
  }

  Future<void> createEntry() async {
    try {
      final String userEmail = user.value!.email;
      final String title = titleController.text;
      final String content = contentController.text;

      if (content.isEmpty || userEmail.isEmpty || title.isEmpty) {
        Get.back();
        Get.snackbar(
          'Required field :)',
          'Please Make sure ur Enty has a title and a content',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red.shade300,
          colorText: Colors.blue.shade800,
        );
        return;
      }

      await _firebaseFirestore.collection("notes").add({
        'userEmail': userEmail,
        'created_at': Timestamp.now(),
        'title': title,
        'content': content,
        'feeling': selectedFeelingOnCreated.value.index,
      });

      Get.back();
      Get.snackbar(
        'Create Entry',
        'Entry with title of $title was created ! :)',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.greenAccent,
        colorText: Colors.blue.shade800,
      );

      await getAllEntrybyEmail();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // GET Percentage
  String getFeelingPercentage(Feeling feelingToFind) {
    final feelingCount = <Feeling, int>{};

    final List<Feeling> allFeelings = [];

    for (final ent in entryList) {
      allFeelings.add(ent.feeling);
    }

    for (final feeling in allFeelings) {
      feelingCount[feeling] = (feelingCount[feeling] ?? 0) + 1;
    }

    final count = feelingCount[feelingToFind];
    if (count == null) return "";

    final String res = ((count / allFeelings.length) * 100).toStringAsFixed(2);

    return res;
  }
}
