import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medium_weather_app/features/controller/weather_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSearch;
  final VoidCallback onGeo;
  const CustomAppBar({super.key, required this.onSearch, required this.onGeo});

  @override
  Widget build(BuildContext context) {
    final wheatherController = Get.put(WeatherController());
    return AppBar(
      backgroundColor: Color(0xFF5B5E73),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF5B5E73),
          border: Border(right: BorderSide(color: Colors.white, width: 2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onSearch,
              icon: Icon(Icons.search, color: Colors.grey),
              constraints: const BoxConstraints(),
              splashRadius: 20,
            ),
            Expanded(
              child: TextField(
                controller: wheatherController.textFieldController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Search location ...",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ),
            ),
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
