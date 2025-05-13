// FIREBASE BACKEND

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarot_club/features/auth/domain/entities/app_user.dart';
import 'package:tarot_club/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepoImpl implements AuthRepo {
  // acess to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // LOGIN : Email and Password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
      );
      return user;
      //catch any errors
    } catch (e) {
      throw Exception('login fail: $e');
    }
  }

  // REGISTER: Email and Password
  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      // attemp register
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
      );
      return user;
    } catch (e) {
      throw Exception('Register failed : $e');
    }
  }

  // LOGOUT
  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  // GET CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async {
    // get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    // no logged in user
    if (firebaseUser == null) return null;

    // logged in user existes
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  // RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Un email de réinitialisation a été envoyé à $email";
    } catch (e) {
      return "An error occured: $e";
    }
  }

  // DELETE ACCOUNT
  @override
  Future<void> deleteAccount() async {
    try {
      //get the current user
      final user = firebaseAuth.currentUser;

      // check if there is a login user
      if (user == null) {
        throw Exception('No user logged in..');
      }

      //delete account
      await user.delete();
      // logout

      await logout();
    } catch (e) {
      throw Exception('failed to delete account: $e');
    }
  }
}
