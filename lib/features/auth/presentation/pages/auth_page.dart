/*
AUTH PAGE - DETERMINE WHETHER TO SHOW LOGIN PAGE OR REGISTER PAGE 
*/

import 'package:flutter/material.dart';
import 'package:tarot_club/features/auth/presentation/pages/login_page.dart';
import 'package:tarot_club/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially show the login page
  bool showLoginPage = true;

  //toggle between pages
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        togglePage: togglePage,
      );
    } else {
      return RegisterPage(
        togglePage: togglePage,
      );
    }
  }
}
