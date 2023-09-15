import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quix_note/firebase_options.dart';
import 'package:quix_note/src/base/app_theme.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/on_boarding/on_boarding.dart';
import 'package:quix_note/src/components/sign_in/social_auth.dart';
import 'package:quix_note/src/utils/dynamic_link.dart';
import 'package:quix_note/src/utils/network_utils.dart';

import 'base/data.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await AppData.initiate();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    DynamicLinkProvide().initDynamicLink();
    NetworkUtils.instance.initialize();
    runApp(const MyApp());
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    NetworkUtils.instance.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: SnackBarService.scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Quix Note',
      navigatorKey: AppNavigation.navigatorKey,
      theme: AppThemes.light,
      // home: OnBoardView()
      home: !AppData.getOnBoardingValue()
          ? const OnBoardView()
          : FirebaseAuth.instance.currentUser != null
              ? NotesPage()
              : const SocialAuthSignIn(),
    );
  }
}
