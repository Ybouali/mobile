import 'package:diary_app/features/screens/entries_screen.dart';
import 'package:diary_app/features/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  static NavController get instance => Get.find();

  final List<Widget> screens = [ProfileScreen(), EntriesScreen()];
  final RxInt selectedIndex = 0.obs;
}
