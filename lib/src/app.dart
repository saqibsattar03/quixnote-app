import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quix_note/firebase_options.dart';
import 'package:quix_note/src/base/app_theme.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/on_boarding/on_boarding.dart';
import 'package:quix_note/src/components/sign_in/social_auth.dart';

import 'base/data.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await AppData.initiate();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark));
    return runApp(const MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quix Note',
      navigatorKey: AppNavigation.navigatorKey,
      theme: AppThemes.light,
      // home: OnBoardView()
      home: !AppData.getOnBoardingValue()
          ? const OnBoardView()
          :
      // FirebaseAuth.instance.currentUser != null
      //         ? const NotesPage()
      //         :
      const SocialAuthSignIn(),
    );
  }
}
