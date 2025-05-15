import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const CustomeButton({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.cyan,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.cyan.shade700,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.cyanAccent),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
