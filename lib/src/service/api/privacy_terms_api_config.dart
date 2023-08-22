import 'package:quix_note/src/models/privacy/privacy.dart';
import 'package:quix_note/src/service/api/base_service.dart';

final class PrivacyTermsApiConfig extends BaseApi {
  Future<List<PrivacyTerms>> getPrivacyPolicy() async {
    try {
      final response = await getRequest(url: '/privacy-policy/all');
      List<PrivacyTerms> list = response.data
          .map<PrivacyTerms>((json) => PrivacyTerms.fromJson(json))
          .toList();
      return list;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<PrivacyTerms>> getTermsAndConditions() async {
    try {
      final response = await getRequest(url: "/terms-and-conditions/all");
      List<PrivacyTerms> list = response.data
          .map<PrivacyTerms>((json) => PrivacyTerms.fromJson(json))
          .toList();
      return list;
    } catch (_) {
      rethrow;
    }
  }
}
