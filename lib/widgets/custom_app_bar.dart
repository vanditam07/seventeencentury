// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFC4D2FF),
      elevation: 1,
      title: const Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seventeen Century',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Manage Your Google Forms',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
      //iconTheme: const IconThemeData(color: Colors.blue), // Set hamburger icon color to blue
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
