import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

class AppThemes {
  static final light = ThemeData.light().copyWith(
    // useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryYellow,
    textTheme: TextTheme(
      titleLarge: const TextStyle(
          color: AppColors.darkTeal,
          fontSize: 29,
          fontFamily: AppFonts.urbanistSemiBold),
      titleMedium: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 18,
          fontFamily: AppFonts.urbanistRegular),
    ),
    dividerTheme: const DividerThemeData(
      space: 1,
      color: Colors.black12,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black26,
      size: 20,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0.0,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
    ),
    // buttonTheme: const ButtonThemeData(
    //   buttonColor: Colors.cyan,
    //   textTheme: ButtonTextTheme.primary,
    // ),
    // appBarTheme: const AppBarTheme(
    //   iconTheme: IconThemeData(color: Colors.black),
    //   actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    // ),
  );

//<--------------------------Dark theme------------------------------->//
  static final dark = ThemeData.dark().copyWith(
    // useMaterial3: true,
    // primaryColor: AppColors.yellow,
    brightness: Brightness.dark,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
    cardTheme: const CardTheme(
      // surfaceTintColor: Colors.white,
      color: Color(0xff2f3448),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20,
    ),
    dividerTheme: const DividerThemeData(space: 1, color: Color(0xffD3D3D3)),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
