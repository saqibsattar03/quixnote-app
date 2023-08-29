import 'dart:io';

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

  Future<String> uploadImage(File imageFile) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final formData = FormData.fromMap({
        'media': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        '/single-file',
        data: formData,
      );
      print('response ${response.data}');

      return response.data as String;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> postFormRequest(Map<String, dynamic> data, File file,
      String filesName, String url) async {
    try {
      late FormData formData;

      formData = FormData.fromMap({
        ...data,
        filesName: await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last)
      });

      final response = await _dio.post(url,
          data: formData, options: Options(contentType: 'multipart/form-data'));
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
