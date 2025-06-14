import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // Log OUT
  Future<void> logOut() async {
    await _auth.signOut();
  }

  // Sign In
  Future<UserCredential?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      // auth details from req
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // return credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Google sign-in error: $e');
      return null;
    }
  }
}
