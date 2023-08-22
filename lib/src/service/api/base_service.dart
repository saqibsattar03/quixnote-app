import 'package:dio/dio.dart';

import '../../utils/api_urls.dart';

base class BaseApi {
  final _dio = Dio(BaseOptions(baseUrl: ApiUrls.baseUrl
//  baseUrl: dotenv.env['baseUrl'] ?? 'API_URL not found',
      ));

  // ..interceptors.add(
  //   AuthorizationInterceptor(),
  // );

  Future<Response> getRequest({
    required String url,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters,);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> postRequest({
    required String url,
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
