import 'package:diary_app/features/components/background.dart';
import 'package:diary_app/features/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to your",
                style: TextStyle(
                  fontFamily: "Tangerine",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Diary",
                style: TextStyle(
                  fontFamily: "Tangerine",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Get.to(() => WelcomeScreen()),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
