import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/bacgound_flowers.jpg",
              fit: BoxFit.cover,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
