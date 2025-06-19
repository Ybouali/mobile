import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/screens/on_bording_screen.dart';
import 'package:diary_app/features/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bacgound_flowers.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.green.shade100,
            BlendMode.darken,
          ),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // logo User
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.greenAccent),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 100,
                child: Image.asset("assets/images/default_user.png"),
              ),
            ),

            // Text full name
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entryController.user.value!.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                // Text email
                Text(
                  entryController.user.value!.email,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),

            // Icon to logOut from app
            IconButton(
              onPressed: () async {
                await AuthService().logoutAuth();
                if (entryController.user.value != null &&
                    !entryController.user.value!.checkExp()) {
                  Get.offAll(() => OnBordingScreen());
                }
              },
              icon: Icon(Icons.login_outlined, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}
