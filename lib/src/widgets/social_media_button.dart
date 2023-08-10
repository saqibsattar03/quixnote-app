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

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: AppColors.lightYellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              assetIcon,
              height: 32,
              width: 32,
            ),
            const SizedBox(
              width: 60,
            ),
            Expanded(
              child: Text(
                title,
                style: textTheme.titleLarge!.copyWith(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
