import 'package:flutter/material.dart';

class ErrorNewWidget extends StatelessWidget {
  final String error;
  const ErrorNewWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(error, style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
