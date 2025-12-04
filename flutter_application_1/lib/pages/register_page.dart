import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

// This is the Registration Page for creating new user accounts
class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Create text controllers to get input from the user
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateOfBirthController = TextEditingController(); // For date of birth
  
  // Variable to store selected date
  DateTime? selectedDate;
  
  // Variable to store selected gender (Male or Female)
  String? selectedGender;

  // Check if the registration form is valid and create the account
  void signUserUp(BuildContext context) {
    // Check: Did user enter a username?
    if (usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a username')),
      );
      return;
    }
    
    // Check: Did user enter an email?
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email')),
      );
      return;
    }
    
    // Check: Did user select a gender?
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your gender')),
      );
      return;
    }
    
    // Check: Did user select a date of birth?
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your date of birth')),
      );
      return;
    }
    
    // Check: Did user enter a password?
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a password')),
      );
      return;
    }
    
    // Check: Do the passwords match?
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    
    // All checks passed! Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful!')),
    );
    
    // Wait 1 second then go back to login page
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
  
  // Function to open date picker when user taps on date field
  Future<void> _selectDate(BuildContext context) async {
    // Show calendar widget for user to pick a date
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Start with today's date
      firstDate: DateTime(1900), // Can pick from 1900 onwards
      lastDate: DateTime.now(), // Can't pick future dates
    );
    // If user selected a date, save it and update the field
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format the date as YYYY-MM-DD
        dateOfBirthController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create the registration page layout
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 6, 58), // Dark blue background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Allow scrolling on small screens
            child: Column(
              children: [
                // Top spacing
                const SizedBox(height: 30),
                
                // Show logo image
                Image.asset(
                  'lib/images/logo.png',
                  height: 100,
                ),
                const SizedBox(height: 10),
                
                // Show app motto
                Text(
                  '"Jamais seul face au diabète."',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: const Color.fromARGB(255, 200, 224, 236),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Show "Register" title
                Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 200, 224, 236),
                  ),
                ),
                const SizedBox(height: 50),
                
                // Show "Registration Information" label
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Registration Information',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 182, 183, 184),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                
                // Username input box
                MyTextfield(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                
                // Email input box
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 3),
                
                // Gender selection (Male/Female) - Slider toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const SizedBox(height: 8),
                      // Slider with Male and Female options
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 231, 231, 235), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Male option - tap to select
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender = 'Male';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: selectedGender == 'Male'
                                        ? const Color.fromARGB(255, 11, 2, 129)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                        color: selectedGender == 'Male'
                                            ? Colors.white
                                            : const Color.fromARGB(255, 100, 100, 100),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Divider line between options
                            Container(
                              width: 1,
                              color: const Color.fromARGB(255, 158, 133, 234),
                            ),
                            // Female option - tap to select
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedGender = 'Female';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: selectedGender == 'Female'
                                        ? const Color.fromARGB(255, 158, 133, 234)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Female',
                                      style: TextStyle(
                                        color: selectedGender == 'Female'
                                            ? Colors.white
                                            : const Color.fromARGB(255, 100, 100, 100),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                
                // Date of birth picker - tap to select date from calendar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () => _selectDate(context), // Open date picker when tapped
                    child: TextField(
                      controller: dateOfBirthController, // Shows the selected date
                      enabled: false, // Users can't type, only use date picker
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(255, 158, 133, 234), width: 2),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: const Color.fromARGB(255, 158, 133, 234), width: 2),
                        ),
                        fillColor:  const Color.fromARGB(255, 235, 236, 237), // Light gray background
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Date of Birth (YYYY-MM-DD)',
                        hintStyle: TextStyle(color: const Color.fromARGB(255, 23, 22, 22)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 27.0),
                        suffixIcon: const Icon(Icons.calendar_today), // Calendar icon
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                
                // Password input box (hidden text)
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                
                // Confirm password input box (hidden text)
                MyTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                
                // Register button
                MyButton(
                  onTap: signUserUp,
                ),
                const SizedBox(height: 30),
                
                // "Already a member? Login here" link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member? ',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 202, 206, 208),
                      ),
                    ),
                    const SizedBox(width: 4),
                    // Click to go back to login page
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 102, 188),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
