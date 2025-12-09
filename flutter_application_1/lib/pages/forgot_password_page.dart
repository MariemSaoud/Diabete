import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

// Forgot Password Page - allows users to reset their password
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // When user clicks "Send Reset Link" button
  void sendResetLink(BuildContext context) {
    print('DEBUG: sendResetLink called');
    // TODO: Add password reset logic here
    // For now, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset link sent! Check your email.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 6, 58), // Dark blue background
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 6, 58),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 200, 224, 236)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Lock icon
                Icon(
                  Icons.lock_reset,
                  size: 100,
                  color: const Color.fromARGB(255, 200, 224, 236),
                ),
                const SizedBox(height: 30),
                // Title
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 200, 224, 236),
                  ),
                ),
                const SizedBox(height: 15),
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Enter your email address and we\'ll send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 182, 183, 184),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Email label
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 182, 183, 184),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Email input box
                MyTextfield(
                  controller: emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                // Send Reset Link button
                MyButton(
                  onTap: sendResetLink,
                  text: 'Send Email',
                ),
                const SizedBox(height: 30),
                // Back to Login link
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 83, 102, 188),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
