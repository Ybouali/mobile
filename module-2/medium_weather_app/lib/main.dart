import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';
import 'package:medium_weather_app/navigation/bottom_nav_menu.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          weatherController.showSearchButton.value = true;
        },
        child: BottomNavMenu(),
      ),
    );
  }
}
