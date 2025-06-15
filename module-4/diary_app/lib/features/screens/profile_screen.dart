import 'package:diary_app/features/screens/widgets/header_profile.dart';
import 'package:diary_app/features/screens/widgets/last_seven_entry.dart';
import 'package:diary_app/features/screens/widgets/last_two_entry.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header profile
              HeaderProfile(),
              Container(height: 2, color: Colors.green),
              SizedBox(height: 10),
              // Last Two Entries
              LastTwoEntry(),
              SizedBox(height: 10),
              // Last 7 entries
              LastSevenEntry(),
              SizedBox(height: 10),
              // Button for new Entry
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(3),
                  ),
                  backgroundColor: Colors.green.shade400,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "New diary entry",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
