import 'package:dio/dio.dart';
import 'package:quix_note/src/base/data.dart';

import '../../utils/api_urls.dart';

base class BaseApi {
  static final _dio = Dio(BaseOptions(baseUrl: ApiUrls.baseUrl))
    ..interceptors.add(AuthorizationInterceptor());

  Future<Response> getRequest({
    required String url,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
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
  Future<Response> patchRequest({
    required String url,
    dynamic data,
  }) async {
    try {
      final response = await _dio.patch(url, data: data);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AppData.accessToken.isNotEmpty) {
      options.headers["Authorization"] = "Bearer ${AppData.accessToken}";
    }
    return handler.next(options);
  }
}
