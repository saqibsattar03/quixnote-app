import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/sign_in/social_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("fo");
          print('hasData => ${snapshot.hasData}');

          if (snapshot.hasData) {
            print("here");
            return const NotesPage();
          } else {
            print("here 1");
            return const SocialAuthSignIn();
          }
        },
      ),
    );
  }
}
