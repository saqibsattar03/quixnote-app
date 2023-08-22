import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
class FormattedDateWidget extends StatelessWidget {
  final DateTime dateTime;

  const FormattedDateWidget({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final formattedDate = DateFormat.yMd().format(dateTime);

    return Text(
      'Last updated on $formattedDate',
      style: textTheme.bodyMedium!
          .copyWith(fontSize: 18, color: AppColors.lightGrey),
    );
  }
}