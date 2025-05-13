import 'package:flutter/material.dart';

class CustumeButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const CustumeButton({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
          border: Border.all(width: 1, color: Colors.cyanAccent),
        ),
        child: Center(child: Text(name)),
      ),
    );
  }
}
