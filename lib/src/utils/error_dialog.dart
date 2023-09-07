import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/utils/api_errors.dart';
import 'package:quix_note/src/utils/firebase_exception.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    this.showHeading = true,
    required this.error,
  }) : super(key: key);
  final bool showHeading;
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    late FirebaseAuthException convertedException;
    if (error is FirebaseException) {
      convertedException =
          FirebaseExceptionConverter.convertErrorCodeToException(error.code);
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeading)
            Text(
              (error is DioError)
                  ? ApiError.withDioError(error).title
                  : 'Error',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (error is DioError)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  ApiError.withDioError(error).toString(),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            )
          else if (error is FirebaseException)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  convertedException.message!,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            )
          else
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  error.toString(),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Ok'),
            ),
          ),
        ],
      ),
    );
  }

  show(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => this,
    );
  }
}
