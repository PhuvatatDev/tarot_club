/*

LOGIN PAGE UI

On this page, a user can login with thier:
-email
-password

----------------------------------------------------------------------------------------------------------------

Once the user Succesfully logs in, they will be directed to homapage 

If user doesn't have an account, they can go to registerpage to create one.

*/


import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title:  Text('Login page'),
        centerTitle: true,
      ),
      // BODY
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.lock_open,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 25),


          // nome of app
          Text(
            "Tarot Club",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          const SizedBox(height: 25),


          // email textfield
          


          // pw textfield


          // forgot pw


          // login button


          // auth sigh in later.... (google + apple)


          // don't have an account? register now!

          
        ],
      ),
    );
  }
}