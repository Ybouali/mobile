import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:advanced_diary_app/features/models/entry_model.dart';
import 'package:advanced_diary_app/features/screens/entry_screen.dart';
import 'package:advanced_diary_app/features/screens/profile_screen.dart';
import 'package:advanced_diary_app/features/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EntryController extends GetxController {
  static EntryController get instance => Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController percentController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();

  final List<Widget> screens = [ProfileScreen(), EntryScreen()];
  final RxInt selectedIndex = 0.obs;

  final Rx<Feeling> selectedFeelingOnCreated = Feeling.happy.obs;
  final RxList<EntryModel> entryList = <EntryModel>[].obs;
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
  void onInit() {
    getAllEntrybyEmail();
    super.onInit();
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
      final User? user = await _auth.getCurrentUser();

      if (user != null) {
        final String useremail = user.email!;
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

  Future<void> deleteEntry(String userEmail, String entryId) async {
    try {
      final User? user = await _auth.getCurrentUser();
      if (user != null && user.email == userEmail) {
        await _firebaseFirestore.collection("notes").doc(entryId).delete();
        await getAllEntrybyEmail();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> updateEntry(EntryModel newEntry, String idEntry) async {
  //   try {
  //     final User? user = await _auth.getCurrentUser();
  //     if (user != null && user.email == newEntry.userEmail) {

  //     }

  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> createEntry() async {
    try {
      final User? user = await _auth.getCurrentUser();

      if (user != null) {
        final String userEmail = user.email!;
        final String title = titleController.text;
        final String content = contentController.text;
        final int percent = int.parse(percentController.text);

        await _firebaseFirestore.collection("notes").add({
          'userEmail': userEmail,
          'created_at': FieldValue.serverTimestamp(),
          'percent': percent,
          'title': title,
          'content': content,
          'feeling': selectedFeelingOnCreated.value.index,
        });

        await getAllEntrybyEmail();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
