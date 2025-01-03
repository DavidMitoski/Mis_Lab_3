import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class AuthService{
  Future<String?> register(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, '/login');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String password, BuildContext context) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, '/');
      });
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return 'Invalid login credentials.';
      } else {
        return e.message;
      }
    }
    catch (e) {
      return e.toString();
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/login');
    });
  }

  String getUserEmail() {
    var userEmail = FirebaseAuth.instance.currentUser?.email ?? 'No email';
    print(userEmail);
    return userEmail;
  }
}
