import 'package:advanced_diary_app/features/controllers/entry_controller.dart';
import 'package:advanced_diary_app/features/screens/on_bording_screen.dart';
import 'package:advanced_diary_app/firebase_options.dart';
import 'package:advanced_diary_app/navigation/bottom_nav_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final EntryController _entryController = Get.put(EntryController());

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await _entryController.initUserIfIsOnStorage();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Tangerine"),
      home: Obx(
        () => _entryController.user.value != null
            ? BottomNavMenu()
            : OnBordingScreen(),
      ),
    );
  }
}
