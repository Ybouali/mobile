// import 'package:ex02/pages/widgets/grid_widget.dart';
import 'package:ex02/pages/widgets/custome_button.dart';
import 'package:ex02/pages/widgets/custome_test_field.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
    final logger = Logger();

    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade400,
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
                      CustomeTestField(label: "0"),

                      const SizedBox(height: 10),
                      // Text Field for the output
                      CustomeTestField(label: "label"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Grid for the buttons
                  Flexible(
                    child: SizedBox(
                      height: orientation == Orientation.portrait ? 350 : 200,
                      child: Scrollbar(
                        child: GridView.count(
                          shrinkWrap: true,
                          physics:
                              orientation == Orientation.portrait
                                  ? NeverScrollableScrollPhysics()
                                  : BouncingScrollPhysics(),
                          crossAxisCount:
                              orientation == Orientation.portrait ? 5 : 5,
                          childAspectRatio:
                              orientation == Orientation.portrait ? 1 : 1.5,
                          children:
                              keys.map((val) {
                                return CustomeButton(
                                  name: val,
                                  onTap: () {
                                    logger.i("button presed :$val");
                                  },
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
