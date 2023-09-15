import 'package:flutter/material.dart';

abstract class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static bool canPop() => navigatorKey.currentState!.canPop();

  static Future<dynamic> push(Widget page) async {
    return await navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static void popAll() {
    return navigatorKey.currentState!.popUntil((route) => false);
  }

  static void pop([dynamic data]) {
    navigatorKey.currentState!.pop(data);
  }

  static void pushAndPopAll(Widget page) {
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page), (route) => false);
  }
}
