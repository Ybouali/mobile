import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EntryCard extends StatelessWidget {
  final VoidCallback? onTap;
  const EntryCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  "16",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "March",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2025",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Emojie
                Icon(
                  Iconsax.emoji_normal,
                  size: 32,
                  color: Colors.red.shade300,
                ),
                const SizedBox(width: 20),
                // Divider
                Container(height: 60, width: 2, color: Colors.black),

                const SizedBox(width: 20),

                // Tille number
                Text(
                  "Tittle 7",
                  style: TextStyle(
                    fontFamily: "Tangerine",
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
