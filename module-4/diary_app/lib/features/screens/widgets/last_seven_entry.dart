import 'package:diary_app/features/components/feel_card.dart';
import 'package:flutter/material.dart';

class LastSevenEntry extends StatelessWidget {
  const LastSevenEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
      margin: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            "Your feel for your 7 entries",
            style: TextStyle(
              fontFamily: "Tangerine",
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FeelCard(),
                  FeelCard(),
                  FeelCard(),
                  FeelCard(),
                  FeelCard(),
                  FeelCard(),
                  FeelCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
