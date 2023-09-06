import 'package:quix_note/src/models/profile/sign_up_model.dart';
import 'package:quix_note/src/service/api/base_service.dart';

import '../../models/profile/sign_in_model.dart';

final class ProfileApiConfig extends BaseApi {
  Future<SignUpModel> signUpUser({required SignUpModel signUpModel}) async {
    try {
      final response =
          await postRequest(url: "/auth/sign-up", data: signUpModel.toJson());
      return SignUpModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<TokenModel> socialSignIn({required SignUpModel signUpModel}) async {
    try {
      final response = await postRequest(
          url: "/auth/social-sign-in", data: signUpModel.toJson());
      return TokenModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<TokenModel> signInUser({required SignInModel signInModel}) async {
    try {
      final response = await postRequest(
          url: "/auth/sign-in-via-email", data: signInModel.toJson());
      return TokenModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<String> getUserUsingIdToken({required String idToken}) async {
    try {
      final response =
          await postRequest(url: "/auth/validate-idToken/$idToken");
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<SignUpModel> getUserUsingAccessToken() async {
    try {
      final response = await getRequest(url: "/auth/person");
      print("${response.data} --------------------------------------------------------------------");
      return SignUpModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String id,
  }) async {
    try {
      final data = {"oldPassword": oldPassword, "newPassword": newPassword};
      print(id);
      final response =
          await patchRequest(url: "/person/update-password/$id", data: data);
      return response.data;
    } catch (_) {
      rethrow;
    }
  }
}
