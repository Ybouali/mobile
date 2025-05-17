import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/components/custom_app_bar.dart';
import 'package:weather_app/features/controller/wheather_controller.dart';

class TodayScreen extends StatelessWidget {
  final String text;
  const TodayScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final wheatherController = Get.put(WheatherController());
    final String city = wheatherController.textFieldController.text;

    return Scaffold(
      appBar: CustomAppBar(
        onSearch: () => wheatherController.onSearch(),
        onGeo: () {},
      ),
      body: Center(
        child: Text(
          '$text\n$city',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
