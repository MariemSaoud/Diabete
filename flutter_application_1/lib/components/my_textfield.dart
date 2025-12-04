import 'package:flutter/material.dart';

// This is a reusable text input box component
class MyTextfield extends StatelessWidget {
    final controller; // Gets the text that user types
    final String hintText; // Placeholder text to show
    final bool obscureText; // Hide text for passwords (true) or show it (false)
    
    const MyTextfield(
      {
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      });

  @override
  Widget build(BuildContext context) {
    // Create the text input box with padding
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: controller,
                  obscureText: obscureText, // Hide or show text
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 158, 133, 234), width: 2), // Purple border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2), // White border when typing
                    ),
                    fillColor:  const Color.fromARGB(255, 235, 236, 237), // Light gray background
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: hintText, // Show placeholder text
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 23, 22, 22)), // Dark gray placeholder text
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 27.0), // Space inside the box
                  ),
                ),
              );
  }
}
  
