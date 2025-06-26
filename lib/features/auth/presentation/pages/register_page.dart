import 'package:flutter/material.dart';
import 'package:tarot_club/features/auth/presentation/components/my_button.dart';
import 'package:tarot_club/features/auth/presentation/components/my_textfild.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;
  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Ajout des contrôleurs pour email et mot de passe
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

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
                  "Let's create an account for you",
                  style: TextStyle(
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                const SizedBox(height: 25),

                // name textfield
                MyTextField(
                  controller: nameController,
                  hintext: "Name",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 16,
                ),

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
                  height: 16,
                ),

                // confirm pw textfiled
                MyTextField(
                  controller: confirmPwController,
                  hintext: "Confirmer le mot de passe",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 25,
                ),

                // register button
                MyButton(
                  onTap: () {},
                  text: "SIGN UP",
                ),

                const SizedBox(
                  height: 25,
                ),

                // auth sigh in later.... (google + apple)

                // already have an account? login now!
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: widget.togglePage,
                      child: Text(
                        "Login now",
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
