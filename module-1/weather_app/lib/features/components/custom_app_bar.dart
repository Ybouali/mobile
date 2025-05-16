import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
                padding: const EdgeInsets.all(0),
                constraints: const BoxConstraints(),
                splashRadius: 20,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
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
              onPressed: () {},
              icon: Icon(Icons.send, size: 25),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
