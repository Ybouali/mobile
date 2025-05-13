// import 'package:ex02/pages/widgets/grid_widget.dart';
import 'package:ex02/pages/widgets/custume_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        title: Center(
          child: Text(
            "Calculator",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder:
              (context, orientation) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      // Text Field for the input
                      TextField(),

                      const SizedBox(height: 10),
                      // Text Field for the output
                      Text("0"),
                    ],
                  ),

                  // Grid for the buttons
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: orientation == Orientation.portrait ? 5 : 8,
                    childAspectRatio:
                        orientation == Orientation.portrait ? 1 : 1.5,
                    children:
                        keys.map((val) {
                          return CustumeButton(name: val, onTap: () {});
                        }).toList(),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
