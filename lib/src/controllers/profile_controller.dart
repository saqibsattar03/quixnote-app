import 'package:flutter/material.dart';
import 'package:quix_note/src/models/profile/sign_up_model.dart';
import 'package:quix_note/src/service/api/profile_api_config.dart';
import 'package:quix_note/src/utils/api_errors.dart';

class ProfileController extends ChangeNotifier {
  ProfileController._();

  static final _instance = ProfileController._();

  static ProfileController get instance => _instance;

  var _isLoading = true;

  bool get isLoading => _isLoading;

  ApiError? _error;

  bool get hasError => _error != null;

  ApiError get error => _error!;

  SignUpModel? _user;

  SignUpModel? get user => _user;

  Future<void> getUser() async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      _user = await ProfileApiConfig().getUserUsingAccessToken();
    } catch (_) {
      _error = ApiError.withDioError(_);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async => await getUser();
}
