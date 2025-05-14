import 'package:flutter/material.dart';

class CustomeTestField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  const CustomeTestField({super.key, required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.cyan.shade200, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.cyan.shade400, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.cyan.shade200, width: 2),
          ),
        ),
      ),
    );
  }
}
