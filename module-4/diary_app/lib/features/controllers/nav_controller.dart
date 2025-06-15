import 'package:diary_app/features/screens/entry_screen.dart';
import 'package:diary_app/features/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  static NavController get instance => Get.find();

  final List<Widget> screens = [ProfileScreen(), EntryScreen()];
  final RxInt selectedIndex = 0.obs;
}
