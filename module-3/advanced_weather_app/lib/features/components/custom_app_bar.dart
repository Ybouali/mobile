import 'package:advanced_weather_app/features/components/location_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:advanced_weather_app/features/controller/weather_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onGeo;
  const CustomAppBar({super.key, required this.onGeo});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());
    return AppBar(
      backgroundColor: Color.fromARGB(255, 56, 0, 75),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 56, 0, 75),
          border: Border(right: BorderSide(color: Colors.white, width: 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              IgnorePointer(
                ignoring: weatherController.searchIsLoading.value,
                child: Obx(() {
                  if (weatherController.showSearchButton.value) {
                    return IconButton(
                      onPressed: () {
                        if (weatherController
                            .textFieldController
                            .text
                            .isNotEmpty) {
                          weatherController.getTheWeatherAndSetTheValues();
                        }
                      },
                      icon: Icon(Icons.search, color: Colors.grey),
                      constraints: const BoxConstraints(),
                      splashRadius: 20,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ),
              // Expanded(child: CitySearchField()),
              Expanded(child: LocationSearchField()),
            ],
          ),
        ),
      ),
      actions: [
        Transform.rotate(
          angle: -0.785398,
          child: IconButton(
            onPressed: onGeo,
            icon: Icon(Icons.send, size: 25, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
