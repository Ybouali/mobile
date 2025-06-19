import 'package:diary_app/features/controllers/entry_controller.dart';
import 'package:diary_app/features/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeelCard extends StatelessWidget {
  final Feeling feeling;
  final IconData icon;
  final Color colorIcon;
  const FeelCard({
    super.key,
    required this.feeling,
    required this.icon,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    final EntryController entryController = Get.put(EntryController());
    final double percent = entryController.getFeelingPercentage(feeling);
    return Row(
      children: [
        const SizedBox(width: 5),
        Icon(icon, size: 32, color: colorIcon),
        const SizedBox(width: 30),
        Text(
          "$percent %",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
