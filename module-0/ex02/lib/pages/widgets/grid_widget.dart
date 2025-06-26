import 'package:ex02/pages/widgets/custome_button.dart';
import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  GridWidget({super.key});

  final List<String> keys = [
    "7",
    "8",
    "9",
    "C",
    "AC",
    "4",
    "5",
    "6",
    "+",
    "-",
    "1",
    "2",
    "3",
    "*",
    "/",
    "0",
    ".",
    "00",
    "%",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        return CustomeButton(name: keys[index], onTap: () {});
      },
    );
  }
}
