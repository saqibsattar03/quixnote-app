import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/service/api/profile_api_config.dart';

import '../../models/profile/sign_up_model.dart';

class SocialAuthService {
  Future<void> signInWithGoogle() async {
    try {
      final gUser = await GoogleSignIn().signIn();

      if (gUser != null) {
        final gAuth = await gUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        final authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = authResult.user;
        if (user != null) {
          final idToken = await user.getIdToken();
          final userModel = SignUpModel(
            fullName: user.displayName!,
            email: gUser.email,
            idToken: idToken,
          );
          final api = ProfileApiConfig();
          final response = await api.socialSignIn(signUpModel: userModel);
          AppData.saveAccessToken(response.accessToken);
          AppNavigation.pushAndPopAll(NotesPage());
        }
      } else {}
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }
}
