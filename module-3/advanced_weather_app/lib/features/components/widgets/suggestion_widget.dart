import 'package:flutter/material.dart';

class SuggestionWidget extends StatelessWidget {
  final String suggestion;
  final VoidCallback onTap;
  const SuggestionWidget({
    super.key,
    required this.suggestion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> newSug = suggestion.split(", ");

    final String first = newSug[0];
    final String secound = newSug.length > 1
        ? ", ${newSug.sublist(1).join(", ")}"
        : "";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1)),
        ),
        child: Row(
          children: [
            const Icon(Icons.apartment, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: first,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: secound),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
