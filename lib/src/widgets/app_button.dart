import 'package:flutter/material.dart';
import 'package:quix_note/src/utils/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
     this.onPressed,
    required this.buttonTitle,
    this.buttonSize,
    this.iconData,
    this.radius,
    this.buttonTitleFontSize,
  }) : super(key: key);

  final Function()? onPressed;
  final String buttonTitle;
  final Size? buttonSize;
  final IconData? iconData;
  final double? radius;
  final double? buttonTitleFontSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: Container(
              height: 35,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 50,
                    spreadRadius: 0,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: buttonSize ?? const Size(200, 50),
            maximumSize: buttonSize ?? const Size(200, 50),
            backgroundColor: AppColors.darkTeal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                radius ?? 8.0,
              ), // Adjust the radius as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonTitle,
                  style: textTheme.titleLarge!.copyWith(
                    fontSize:buttonTitleFontSize?? 16,
                    color: Colors.white,
                  ),
                ),
                if (iconData != null) ...[
                  const SizedBox(width: 10),
                  Icon(
                    iconData,
                    color: Colors.white,
                  )
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
