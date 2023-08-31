import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';



class BoardingLayout extends StatelessWidget {
  const BoardingLayout({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.urlImage,
    required this.controller,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String urlImage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              controller.jumpToPage(2);
            },
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                      fontSize: 18, // Set the font size of the text
                      fontFamily:
                          AppFonts.gilroyMedium // Set the color of the text
                      ),
                ),
                foregroundColor:
                    MaterialStateProperty.all(AppColors.lightGrey)),
            child: const Text('Skip'),
          ),
          const SizedBox(
            height: 40,
          ),
         SizedBox(height:220,width:double.infinity,child:  SvgPicture.asset(urlImage),),
          const SizedBox(
            height: 60,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 350,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.darkGrey, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
