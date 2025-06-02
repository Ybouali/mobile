import 'package:advanced_weather_app/features/components/custom_app_bar.dart';
import 'package:advanced_weather_app/features/components/widgets/suggestion_widget.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final weatherController = Get.put(WeatherController());
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onGeo: () => weatherController.getCurrentLocation()),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: ListView.builder(
            itemCount: weatherController.suggestionList.value.length,
            itemBuilder: (context, index) {
              return SuggestionWidget(
                suggestion: weatherController.suggestionList.value[index],
                onTap: () {
                  weatherController.showSearchButton.value = true;
                  weatherController.textFieldController.text =
                      weatherController.suggestionList.value[index];
                  weatherController.suggestionList.value = [];
                },
              );
            },
          ),
        );
      }),
    );
  }
}
