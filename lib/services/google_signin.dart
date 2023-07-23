import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/widgets/dialogBox.dart';

class GoogleServices {
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static signInWithGoogle(BuildContext context) async {
    showLoading(context);
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();
    if (gUser == null) {
      Navigator.pop(context);
    } else {
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => Navigator.pop(context));
    }
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
    googleSignIn.disconnect();
  }
}
