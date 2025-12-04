import 'package:flutter/material.dart';

// This is the Home Page that shows after user logs in
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the home page layout
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 6, 58), // Dark blue background
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show welcome message
              Text(
                'Welcome to Home',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 200, 224, 236),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
