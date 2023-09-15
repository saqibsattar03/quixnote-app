import 'package:quix_note/src/service/api/base_service.dart';

import '../../models/faq/faq_model.dart';

final class FAQApiConfig extends BaseApi {
  Future<List<FaqModel>> getFaq() async {
    try {
      final response = await getRequest(url: "/faq/all");
      return response.data.map<FaqModel>((json) => FaqModel.fromJson(json)).toList();
    } catch (_) {
      rethrow;
    }
  }
}
