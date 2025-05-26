import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tarot_club/features/auth/presentation/pages/login_page.dart';
import 'package:tarot_club/firebase_options.dart';
import 'package:tarot_club/themes/dark_mode.dart';
import 'package:tarot_club/themes/light_mode.dart';

void main() async{
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
