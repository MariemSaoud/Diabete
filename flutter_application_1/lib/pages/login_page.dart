//les lien pour chaque page 
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/components/square_tile.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/forgot_password_page.dart';

// This is the Login Page that shows when the app starts
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  
  // Create text controllers to get username and password from the user
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // When user clicks "Sign in" button, go to the home page
  void signUserIn(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  
  @override
  Widget build(BuildContext context) {
    // Create the login page layout
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 6, 58), // Dark blue background
      body: SafeArea(
        child: Center(
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
                Text('"Jamais seul face au diabète."', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: const Color.fromARGB(255, 200, 224, 236)),), 
                const SizedBox(height: 10),
              
              // Show "Login Page" title
              Text('Login Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 200, 224, 236)),),
              const SizedBox(height: 40),
              
              // Show "Login Information" label
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 182, 183, 184))),
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
              
              // Password input box (hidden text)
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              
              // "Forgot Password?" button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 102, 188),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              
              // Sign in button
              MyButton(
                onTap: signUserIn,
              ),
              const SizedBox(height: 37),

              // "or continue with" divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: const Color.fromARGB(255, 93, 103, 122),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: 
                      Text(
                        'or continue with', 
                      style: TextStyle(color: const Color.fromARGB(255, 213, 218, 220)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: const Color.fromARGB(255, 101, 112, 134),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Google and Apple login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 SquareTile(imagePath:  'lib/images/google.png',),
                 const  SizedBox(width: 25,),
                 SquareTile(imagePath:  'lib/images/apple.png',),   
                ],
              ),
              const SizedBox(height: 50),
              
              // "Not a member? Register now" link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member? ', style: TextStyle(color: const Color.fromARGB(255, 202, 206, 208)),),
                  const SizedBox(width: 4,),
                  // Click to go to register page
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text('Register now', style: TextStyle(color: const Color.fromARGB(255, 83, 102, 188), fontWeight: FontWeight.bold),),
                  ),
                ],
              ),  
            ],
          ),
        ),
      ),
    );
  }
}
