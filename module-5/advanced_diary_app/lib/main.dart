import 'package:advanced_diary_app/features/screens/on_bording_screen.dart';
import 'package:advanced_diary_app/features/services/auth/auth_service.dart';
import 'package:advanced_diary_app/firebase_options.dart';
import 'package:advanced_diary_app/navigation/bottom_nav_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initializeDateFormatting("", "");
  final AuthService authService = AuthService();

  final User? user = await authService.getCurrentUser();

  runApp(MyApp(initUser: user));
}

class MyApp extends StatelessWidget {
  final User? initUser;
  const MyApp({super.key, this.initUser});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: initUser != null ? BottomNavMenu() : OnBordingScreen(),
    );
  }
}
