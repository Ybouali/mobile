import 'package:diary_app/features/components/new_entry_button.dart';
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

              // Button for new Entry
              NewEntryButton(),
            ],
          ),
        ),
      ),
    );
  }
}
