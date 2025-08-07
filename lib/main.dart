import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarot_club/app.dart';
import 'package:tarot_club/features/auth/data/firebase_auth_repo_impl.dart';
import 'package:tarot_club/features/auth/domain/repos/auth_repo.dart';
import 'package:tarot_club/config/firebase/firebase_options.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // run app
  runApp(RepositoryProvider<AuthRepo>(
    create: (_) => FirebaseAuthRepo(),
    child: MyApp(),
  ));
}
