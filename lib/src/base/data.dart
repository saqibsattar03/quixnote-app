import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static late SharedPreferences _sharedPreferences;
  static const _onBoardingKey = "on_boarding_key";

  static Future<void> initiate() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getOnBoardingValue() =>
      _sharedPreferences.getBool(_onBoardingKey) ?? false;

  static Future<void> setOnBoardingValue(value) =>
      _sharedPreferences.setBool(_onBoardingKey, value);
}
