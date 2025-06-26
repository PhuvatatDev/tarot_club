import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/features/auth/data/firebase_auth_repo_impl.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tarot_club/features/auth/presentation/cubits/auth_state.dart';
import 'package:tarot_club/features/home/presentation/pages/home_page.dart';
import 'package:tarot_club/firebase_options.dart';
import 'package:tarot_club/themes/dark_mode.dart';
import 'package:tarot_club/themes/light_mode.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // run app
  runApp( MyApp());
}

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

        /*

        Bloc Consumer -Auth

        */
        home: BlocConsumer(
          builder: (context, state){
            //unauthenticated -> auth page (login/register)
            if(state is Authenticated){
              return const HomePage();
            }
            // loading....
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }, 
          // listen for state changes
          listener: (context, state){
            if (state is AuthError){
              ScaffoldMessenger.of( context ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            
          })
      ),
    );
  }
}
