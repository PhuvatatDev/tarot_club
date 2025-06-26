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
import 'package:tarot_club/features/auth/presentation/components/my_button.dart';
import 'package:tarot_club/features/auth/presentation/components/my_textfild.dart'; // Ajout de l'import

class LoginPage extends StatefulWidget {
    // toggle page fonction import from auth_page
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Ajout des contrôleurs pour email et mot de passe
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return SafeArea(
      child: Scaffold(
        // APPBAR
        appBar: AppBar(
          title: Text('Login page'),
          centerTitle: true,
        ),
        // BODY
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
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
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintext: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 16),

                // pw textfield
                MyTextField(
                  controller: passwordController,
                  hintext: "Mot de passe",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                // forgot pw
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Mot de Passe oublier",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // login button
                MyButton(
                  onTap: () {},
                  text: "LOGIN",
                ),

                const SizedBox(
                  height: 25,
                ),

                // auth sigh in later.... (google + apple)

                // don't have an account? register now!
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have a accont?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: widget.togglePage,
                      child: Text(
                        "register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
