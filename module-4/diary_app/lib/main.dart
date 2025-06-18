import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/screens/on_bording_screen.dart';
import 'package:diary_app/firebase_options.dart';
import 'package:diary_app/navigation/bottom_nav_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(e.toString());
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final EntryController entryController = Get.put(EntryController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: entryController.user.value != null
          ? BottomNavMenu()
          : OnBordingScreen(),
    );
  }
}
