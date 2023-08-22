import 'package:flutter/material.dart';

abstract class AppUtils{
  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static FormFieldValidator<String>? email({
    String message = 'This is not a valid email address',
  }) {
    return (String? value) {
      if (value?.isEmpty ?? true) return 'Email is required.';
      if (_emailRegExp.hasMatch(value ?? '')) return null;
      return 'Please provide a valid email';
    };
  }
}