import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/features/auth/presentation/components/my_button.dart';
import 'package:tarot_club/features/auth/presentation/components/my_textfild.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_state.dart';

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

  void register() {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String pw = passwordController.text;
    final String confirmPw = confirmPwController.text;

    // get the authcubit
    final authCubit = context.read<AuthCubit>();

    // ensure fields aren't empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      // ensure pw match
      if (pw == confirmPw) {
        authCubit.register(name, email, pw);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('password do not match!')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please complete all fields!")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPwController.dispose();
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
                        "Let's create an account for you",
                        style: TextStyle(
                          fontSize: 26,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: nameController,
                        hintext: "Name",
                        obscureText: false,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      MyTextField(
                        controller: confirmPwController,
                        hintext: "Confirmer le mot de passe",
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      MyButton(
                        onTap: register,
                        text: "SIGN UP",
                      ),
                      const SizedBox(height: 16),
                      if (state is AuthLoading)
                        const CircularProgressIndicator(),
                      const SizedBox(height: 25),
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
                              " Login now",
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
