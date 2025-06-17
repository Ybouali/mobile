import 'package:flutter/material.dart';

class FeelCard extends StatelessWidget {
  final int percent;
  final IconData icon;
  final Color colorIcon;
  const FeelCard({
    super.key,
    required this.percent,
    required this.icon,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Icon(icon, size: 32, color: colorIcon),
        const SizedBox(width: 30),
        Text(
          "$percent %",
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
