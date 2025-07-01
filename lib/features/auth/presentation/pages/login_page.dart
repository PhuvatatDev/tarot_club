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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/features/auth/presentation/components/my_button.dart';
import 'package:tarot_club/features/auth/presentation/components/my_textfild.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_state.dart'; // Ajout de l'import

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

  void login() {
    final String email = emailController.text.trim();
    final String pw = passwordController.text;
    // get the authcubit
    final authCubit = context.read<AuthCubit>();

    // ensure fields aren't empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter both email and password")));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login page'),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: SingleChildScrollView(
                  // Ajout pour éviter débordement clavier
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_open,
                        size: 80,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Tarot Club",
                        style: TextStyle(
                          fontSize: 26,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: emailController,
                        hintext: "Email",
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
                      MyTextField(
                        controller: passwordController,
                        hintext: "Mot de passe",
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),

                      // todo: create une fonction de recuperation de mot de passe 
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
                      const SizedBox(height: 25),
                      MyButton(
                        onTap: login,
                        text: "LOGIN",
                      ),
                      const SizedBox(height: 16),
                      if (state is AuthLoading)
                        const CircularProgressIndicator(),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          GestureDetector(
                            onTap: widget.togglePage,
                            child: Text(
                              " register now",
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
            );
          },
        ),
      ),
    );
  }
}
