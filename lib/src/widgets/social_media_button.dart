import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/utils/app_colors.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
    required this.title,
    required this.assetIcon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String assetIcon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.lightYellow,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            assetIcon,
            height: 32,
            width: 32,
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Text(
              title,
              style: textTheme.titleLarge!.copyWith(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
