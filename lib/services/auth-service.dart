import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/showSnackBar.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  User get user {
    return _auth.currentUser!;
  }

  Stream<User?> get authState => _auth.authStateChanges();

  Future<UserCredential?> signUp(
      String email, String password, BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "Email is already in use.");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<UserCredential?> signIn(
      String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "User is not found");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return null;
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message != null ? e.message! : "Log out failed");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
