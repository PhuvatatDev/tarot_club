// AuthGate is responsible for listening to the current authentication state
// and building the appropriate UI accordingly.
// 
// It reacts to:
// - AuthLoading => shows a loading indicator
// - Authenticated => navigates to HomePage
// - Unauthenticated or Error => shows AuthPage (login/register)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_state.dart';
import 'package:tarot_club/features/auth/presentation/pages/auth_page.dart';
import 'package:tarot_club/features/home/presentation/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (context, state) {
      if (state is AuthLoading) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is Authenticated) {
        return HomePage();
      } else {
        return const AuthPage();
      }
    });
  }
}
