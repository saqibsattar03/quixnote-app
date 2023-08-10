import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/utils/app_images.dart';

class AppAlertDialog extends StatelessWidget {
  final String message;

  const AppAlertDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(30),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImages.successIcon,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
