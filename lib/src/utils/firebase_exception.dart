import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionConverter {
  static FirebaseAuthException convertErrorCodeToException(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return FirebaseAuthException(
          code: "auth/email-already-in-use",
          message: "Email already used. Go to login page.",
        );
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return FirebaseAuthException(
          code: "auth/wrong-password",
          message: "Wrong email/password combination.",
        );
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return FirebaseAuthException(
          code: "auth/user-not-found",
          message: "No user found with this email.",
        );
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return FirebaseAuthException(
          code: "auth/user-disabled",
          message: "User disabled.",
        );
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return FirebaseAuthException(
          code: "auth/too-many-requests",
          message: "Too many requests to log into this account.",
        );
      case "ERROR_OPERATION_NOT_ALLOWED":
        return FirebaseAuthException(
          code: "auth/operation-not-allowed",
          message: "Server error, please try again later.",
        );
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return FirebaseAuthException(
          code: "auth/invalid-email",
          message: "Email address is invalid.",
        );
      default:
        return FirebaseAuthException(
          code: "auth/login-failed",
          message: "Login failed. Please try again.",
        );
    }
  }
}