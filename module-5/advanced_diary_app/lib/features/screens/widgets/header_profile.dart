import 'package:advanced_diary_app/features/screens/on_bording_screen.dart';
import 'package:advanced_diary_app/features/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 170,
      // color: Colors.amber,
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
      child: Row(
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
                "Yassine Bouali",
                style: TextStyle(
                  fontFamily: "Tangerine",
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              // Text email
              Text(
                "yassine.bouali.bo@gmail.com",
                style: TextStyle(
                  fontFamily: "Tangerine",
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          // Icon to logOut from app
          IconButton(
            onPressed: () async {
              await AuthService().logOut();
              Get.offAll(() => OnBordingScreen());
            },
            icon: Icon(Icons.login_outlined, size: 32),
          ),
        ],
      ),
    );
  }
}
