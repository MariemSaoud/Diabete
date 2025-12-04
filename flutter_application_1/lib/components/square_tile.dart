import 'package:flutter/material.dart';

// This is a reusable square button that shows an image (for Google, Apple login, etc.)
class SquareTile extends StatelessWidget {
  final String imagePath; // Path to the image file to display
  
  const SquareTile({
    super.key,
    required this.imagePath,});

  @override
  Widget build(BuildContext context) {
    // Create a square box with an image inside
    return Container(
      padding: const EdgeInsets.all(20), // Space inside the box
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 234, 230, 230)), // Light gray border
        color: const Color.fromARGB(255, 234, 234, 234), // Light gray background
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Image.asset(
        imagePath,
        height: 40, // Size of the image
      ),
    );
  }
}