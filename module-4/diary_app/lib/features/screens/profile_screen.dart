import 'package:diary_app/features/screens/on_bording_screen.dart';
import 'package:diary_app/features/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().logOut();
              Get.offAll(() => OnBordingScreen());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text("HOME SCREEN")),
    );
  }
}
