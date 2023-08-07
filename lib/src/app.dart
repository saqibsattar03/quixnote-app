import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quix_note/src/base/app_theme.dart';
import 'package:quix_note/src/components/on_boarding/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/home/home_page.dart';

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark
    ));
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool("showHome") ?? false;
    return runApp(MyApp(showHome: showHome));
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quix Note',
        theme: AppThemes.light,
        home: OnBoardView());
  }
}
