// import 'package:ex02/pages/widgets/grid_widget.dart';
import 'package:ex03/controller/operation_controller.dart';
import 'package:ex03/pages/widgets/custome_button.dart';
import 'package:ex03/pages/widgets/custome_test_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    "=",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    final OperationController controller = OperationController();

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
              (context, orientation) => LayoutBuilder(
                builder:
                    (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              // Text Field for the input
                              CustomeTestField(
                                controller: controller.inputController,
                              ),

                              const SizedBox(height: 5),
                              // Text Field for the output
                              CustomeTestField(
                                controller: controller.resultController,
                              ),

                              // const SizedBox(height: 10),
                              Spacer(),

                              // Grid for the buttons
                              SizedBox(
                                height:
                                    isOnLargScreen(context)
                                        ? orientation == Orientation.portrait
                                            ? 400
                                            : 300
                                        : orientation == Orientation.portrait
                                        ? 350
                                        : 200,
                                child: Scrollbar(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 5,
                                    childAspectRatio:
                                        isOnLargScreen(context)
                                            ? orientation ==
                                                    Orientation.portrait
                                                ? 2
                                                : 4
                                            : orientation ==
                                                Orientation.portrait
                                            ? 1
                                            : 6,
                                    children:
                                        keys.map((val) {
                                          return CustomeButton(
                                            name: val,
                                            onTap:
                                                () => controller.operation(
                                                  context,
                                                  val,
                                                ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              ),
        ),
      ),
    );
  }

  bool isOnLargScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }
}
