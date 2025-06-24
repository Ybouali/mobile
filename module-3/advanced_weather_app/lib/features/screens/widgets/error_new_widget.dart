import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorNewWidget extends StatelessWidget {
  final String error;
  const ErrorNewWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Lottie.asset("assets/animations/error/error_animation.json"),
            Text(
              error,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
