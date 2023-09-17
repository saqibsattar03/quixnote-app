import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
   // var theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        title,
        // style: theme.textTheme.displayMedium!.copyWith(
        //   fontSize: 18,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      content: Text(
        message,
        // style: theme.textTheme.displayMedium!.copyWith(
        //   fontSize: 16,
        //   fontWeight: FontWeight.normal,
        // ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'No',
            // style: theme.textTheme.displayMedium!.copyWith(
            //   fontSize: 14,
            // ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(
            'Yes',
            // style: theme.textTheme.displayMedium!.copyWith(
            //   fontSize: 14,
            // ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (_) => this,
    ) ??
        false;
  }
}
