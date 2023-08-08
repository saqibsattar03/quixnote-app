import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quix_note/src/base/app_theme.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/on_boarding/on_boarding.dart';
import 'package:quix_note/src/components/sign_up/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/data.dart';
import 'components/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
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
        theme: AppThemes.light,
        home: AppData.getOnBoardingValue() ? const NotesPage() : const OnBoardView());
  }
}
