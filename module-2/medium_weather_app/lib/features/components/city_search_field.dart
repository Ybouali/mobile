import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class CitySearchField extends StatelessWidget {
  const CitySearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());
    return TypeAheadField<String>(
      controller: weatherController.textFieldController,
      suggestionsCallback: (String search) async {
        weatherController.textFieldController.text = search;
        return await weatherController.fetchCitySuggestions();
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Search City',
            border: OutlineInputBorder(),
          ),
        );
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(title: Text(suggestion));
      },
      onSelected: (String suggestion) {
        weatherController.textFieldController.text = suggestion;
        print('Selected city: $suggestion');
      },
    );
  }
}
