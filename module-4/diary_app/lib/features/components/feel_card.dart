import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FeelCard extends StatelessWidget {
  const FeelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Icon(Iconsax.emoji_happy, size: 32, color: Colors.blueAccent),
        const SizedBox(width: 30),
        Text(
          "30 %",
          style: TextStyle(
            fontFamily: "Tangerine",
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
