import 'package:dio/dio.dart';

class ApiError implements Exception {
  late String title;
  late String description;

  ApiError({required this.description, required this.title});

  ApiError.withDioError(error) {
    title = 'Error';
    description = '';

    switch (error.type) {
      case DioErrorType.cancel:
        description = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectionTimeout:
        description = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        description = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        description = 'Request send timeout.';
        break;
      case DioErrorType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response!.data['message'];

        String newMessage = _handleStatusCode(statusCode, message);

        // if (newMessage.toLowerCase().contains('user not found')) {
        //   title = newMessage;
        //   description = 'User not found against this email';
        // } else if (newMessage.toLowerCase().contains('invalid credentials')) {
        //   title = newMessage;
        //   description = 'You entered wrong email or password';
        // } else if (newMessage
        //     .toLowerCase()
        //     .contains('user with this email/username already exists!')) {
        //   title = 'Use different account';
        //   description = newMessage;
        // } else if (newMessage.toLowerCase().contains(
        //     'e11000 duplicate key error collection: test.groups index: username_1 dup key:')) {
        //   title = 'Group exist with this username';
        //   description = 'Try to add unique username';
        // } else {
        //   description = newMessage;
        // }

           description = _handleStatusCode(statusCode, message);
        break;
      case DioErrorType.connectionError:
        description = 'Connectivity issue';
        break;
      case DioErrorType.unknown:
        title = 'Connectivity issue';
        description = 'Please check your internet connection';
        break;
      default:
        description = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode, String? message) {
    switch (statusCode) {
      case 400:
        return message ?? 'Bad request.';
      case 401:
        return message ?? 'Authentication failed.';
      case 403:
        return message ??
            'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return message ?? 'The requested resource does not exist.';
      case 409:
        return message ?? 'Account already exist.';
      case 405:
        return message ??
            'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return message ??
            'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return message ?? 'Data validation failed.';
      case 429:
        return message ?? 'Too many requests.';
      case 500:
        return message ?? 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => description;
}