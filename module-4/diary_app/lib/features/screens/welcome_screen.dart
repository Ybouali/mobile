import 'package:diary_app/features/services/auth/auth_service.dart';
import 'package:diary_app/navigation/bottom_nav_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Login
            Icon(Icons.login, size: 32, color: Colors.blue.shade400),
            // Text Welcome
            Text(
              "Welcome",
              style: TextStyle(
                fontFamily: "Tangerine",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Login with google Or github",
              style: TextStyle(
                fontFamily: "Tangerine",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () async {
                final UserCredential? userCredential = await AuthService()
                    .signIn();

                if (userCredential != null) {
                  Get.offAll(() => BottomNavMenu());
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Google Icon
                  Image.asset(
                    "assets/icons/google-logo.png",
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 10),

                  // Text
                  Text(
                    "Continue with Google",
                    style: TextStyle(
                      fontFamily: "Tangerine",
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Google Icon
                  Image.asset(
                    "assets/icons/github_icon.png",
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 10),
                  // Text
                  Text(
                    "Continue with Github",
                    style: TextStyle(
                      fontFamily: "Tangerine",
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
