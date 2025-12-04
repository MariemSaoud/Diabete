import 'package:flutter/material.dart';

// This is a reusable button component
class MyButton extends StatelessWidget {
  final Function(BuildContext)? onTap; // Function to run when button is tapped

  const MyButton({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    // Create a clickable button
    return GestureDetector(
      onTap: () => onTap!(context), // Run the function when tapped
      child: Container(
        padding: const EdgeInsets.all(25), // Space inside the button
        margin: const EdgeInsets.symmetric(horizontal: 25), // Space around the button
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 75, 150), // Blue button color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Center(
          child: Text(
            'Sign in',
            style: TextStyle(
              color: const Color.fromARGB(255, 233, 233, 235), // Light text color
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}