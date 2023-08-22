import 'package:dio/src/response.dart';
import 'package:quix_note/src/models/profile/sign_up_model.dart';
import 'package:quix_note/src/service/api/base_service.dart';

import '../../models/profile/sign_in_model.dart';

final class ProfileApiConfig extends BaseApi{
  Future<SignUpModel> signUpUser({required SignUpModel signUpModel}) async {
    try {
      final response = await postRequest(url: "/auth/sign-up", data: signUpModel.toJson());
      return SignUpModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }


  Future<Map<String, dynamic>> signInUser({required SignInModel signInModel}) async {
    try {
      final response = await postRequest(url: "/auth/sign-in", data: signInModel.toJson());
      print(response.data);
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<String> getUserUsingIdToken({required String idToken}) async {
    try {
      final response = await postRequest(url: "/auth/validate-idToken/${idToken}");
      return response.data;
    } catch (_) {
      rethrow;
    }
  }
}