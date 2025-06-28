import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/components/city_search_field.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onGeo;
  final VoidCallback onPress;
  const CustomAppBar({super.key, required this.onGeo, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());
    return AppBar(
      backgroundColor: Color(0xFF5B5E73),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF5B5E73),
          border: Border(right: BorderSide(color: Colors.white, width: 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            IgnorePointer(
              ignoring: weatherController.searchIsLoading.value,
              child: Obx(() {
                if (weatherController.showSearchButton.value) {
                  return IconButton(
                    onPressed: onPress,
                    icon: Icon(Icons.search, color: Colors.grey),
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ),
            Expanded(child: CitySearchField()),
          ],
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
