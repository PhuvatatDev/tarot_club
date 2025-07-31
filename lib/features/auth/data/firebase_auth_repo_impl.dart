// FIREBASE BACKEND

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarot_club/features/auth/domain/entities/app_user.dart';
import 'package:tarot_club/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  // acess to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // LOGIN : Email and Password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // 1. Connexion à Firebase Auth
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      // 2. Lire le document Firestore `users/{uid}`
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        throw Exception(
            "L'utilisateur est connecté, mais ses données sont absentes.");
      }

      // 3. Convertir le document Firestore en AppUser
      return AppUser.fromJson(doc.data()!);

      // 4. Gestion des erreurs
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('Aucun utilisateur trouvé pour cet email.');
        case 'wrong-password':
          throw Exception('Mot de passe incorrect.');
        case 'invalid-email':
          throw Exception('Adresse email invalide.');
        case 'too-many-requests':
          throw Exception('Trop de tentatives. Réessayez plus tard.');
        default:
          throw Exception('Échec de la connexion : ${e.message}');
      }
    } catch (e) {
      throw Exception('Erreur inattendue lors de la connexion.');
    }
  }

  // REGISTER: Email and Password
  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      // 1. Créer compte Firebase Auth
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Stocker le displayName pour FirebaseAuth (non obligatoire)
      await userCredential.user!.updateDisplayName(name);

      final uid = userCredential.user!.uid;

      // 3. Attendre que le backend ait créé le document Firestore
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

      final doc = await docRef.get();

      if (!doc.exists) {
        throw Exception(
            "L'utilisateur a été créé, mais les données sont absentes.");
      }

      // 4. Convertir les données Firestore en AppUser
      return AppUser.fromJson(doc.data()!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception("Cet email est déjà utilisé.");
        case 'invalid-email':
          throw Exception("L'email est invalide.");
        case 'weak-password':
          throw Exception(
              "Le mot de passe est trop faible (min. 6 caractères).");
        default:
          throw Exception("Échec de l'inscription : ${e.message}");
      }
    } catch (e) {
      throw Exception("Erreur inattendue lors de l'inscription.");
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
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
    );
  }

  // RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Un email de réinitialisation a été envoyé à $email";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return "Aucun utilisateur avec cet email.";
        case 'invalid-email':
          return "Email invalide.";
        default:
          return "Échec de l'envoi de l'email : ${e.message}";
      }
    } catch (e) {
      return "Erreur inconnue pendant la réinitialisation du mot de passe.";
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
