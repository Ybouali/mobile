import 'package:advanced_weather_app/features/controller/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class CitySearchField extends StatelessWidget {
  const CitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();

    return TypeAheadField<String>(
      controller: weatherController.textFieldController,
      suggestionsCallback: (String search) async {
        if (search.isEmpty) return [];
        weatherController.showSearchButton.value = false;
        return await weatherController.fetchCitySuggestions();
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: weatherController.textFieldController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            hintText: 'Search City',
            border: InputBorder.none,
          ),
          onTap: () {
            weatherController.showSearchButton.value = true;
          },
        );
      },
      itemBuilder: (context, String suggestion) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1)),
          ),
          child: Text(suggestion),
        );
      },
      onSelected: (String suggestion) {
        weatherController.showSearchButton.value = true;
        weatherController.textFieldController.text = suggestion;
      },
    );
  }
}
