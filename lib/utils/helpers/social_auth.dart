import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taxiappdriver/screens/auth/login_screen.dart';
import 'package:taxiappdriver/screens/zoom_drawer/zoom_drawer_screen.dart';

class SocialAuth {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const ZoomDrawerScreen();
          } else {
            return const LoginScreen();
          }
        });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log('Google sign-in aborted by user');
        return null;
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      if (googleAuth == null) {
        log('Failed to retrieve Google authentication details');
        return null;
      }

      log('Google access token: ${googleAuth.accessToken}');
      log('Google ID token: ${googleAuth.idToken}');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('Error during Google sign-in: $e');
      return null;
    }
  }

  //Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
