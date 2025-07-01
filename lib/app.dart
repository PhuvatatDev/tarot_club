
// MyApp is the root widget of the application.
// It wraps the app with a MultiBlocProvider for AuthCubit,
// applies light/dark themes, and sets AuthGate as the main entry point,
// which displays the appropriate screen based on the authentication state.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/features/auth/data/firebase_auth_repo_impl.dart';
import 'package:tarot_club/features/auth/presentation/pages/auth_gate.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tarot_club/themes/dark_mode.dart';
import 'package:tarot_club/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final firebaseAuthRepo = FirebaseAuthRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // provide cubit to app
      providers: [
        //auth cubit
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),),
      ],

      // app 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        home: const AuthGate()
      ),
    );
  }
}
