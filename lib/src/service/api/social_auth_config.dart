

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthService {
  signInWithGoogle() async{
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAtuh = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAtuh.accessToken,
      idToken: gAtuh.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}