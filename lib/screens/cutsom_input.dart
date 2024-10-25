import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller, // Add controller as a required parameter
    required this.hint,
    this.obscure = false,
    this.icon = const Icon(Icons.person),
  });

  final TextEditingController controller; // Added controller property
  final String hint;
  final bool obscure;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextField(
        controller: controller, // Set the controller for the TextField
        obscureText: obscure,
        decoration: InputDecoration(
          icon: icon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
