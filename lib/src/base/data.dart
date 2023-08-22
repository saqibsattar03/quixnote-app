import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  AppData._();
  static late SharedPreferences _sharedPreferences;
  static const _onBoardingKey = "on_boarding_key";
  static const accessTokenKey = 'accessTokenKey';
  static const loggedUserIdKey = 'loggedUserIdKey';
  static const userKey = 'user';

  static Future<void> initiate() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getOnBoardingValue() =>
      _sharedPreferences.getBool(_onBoardingKey) ?? false;

  static Future<void> setOnBoardingValue(value) =>
      _sharedPreferences.setBool(_onBoardingKey, value);


  static Future<void> saveAccessToken(String accessToken) async {
    await _sharedPreferences.setString(accessTokenKey, accessToken);
  }

  static String get accessToken => _sharedPreferences.getString(accessTokenKey) ?? '';



  static Future<void> saveUserId(String id) async {
    await _sharedPreferences.setString(loggedUserIdKey, id);
  }

  static String get loggedUserId => _sharedPreferences.getString(loggedUserIdKey) ?? '';
}
