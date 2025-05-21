import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class CitySearchField extends StatelessWidget {
  const CitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();

    return TypeAheadField<String>(
      controller: weatherController.textFieldController,
      suggestionsCallback: (String search) async {
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
        weatherController.textFieldController.text = suggestion;
        weatherController.showSearchButton.value = true;
      },
    );
  }
}
