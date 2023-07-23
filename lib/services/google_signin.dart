import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleServices {
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
    googleSignIn.disconnect();
  }
}
