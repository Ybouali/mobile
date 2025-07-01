import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/models/user_model.dart';
import 'package:diary_app/features/screens/on_bording_screen.dart';
import 'package:diary_app/firebase_options.dart';
import 'package:diary_app/navigation/bottom_nav_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final EntryController entryController = Get.put(EntryController());

  await entryController.initUserIfIsOnStorage();
  await entryController.getAllEntrybyEmail();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Tangerine"),
      home: Obx(() {
        if (entryController.user.value != UserModel.empty() &&
            entryController.user.value!.email.isNotEmpty) {
          return BottomNavMenu();
        } else {
          return OnBordingScreen();
        }
      }),
    );
  }
}
