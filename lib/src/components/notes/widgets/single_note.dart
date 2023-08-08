import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_fonts.dart';
import 'package:quix_note/src/utils/app_images.dart';

class SingleNote extends StatelessWidget {
  const SingleNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text("01/", style: Theme.of(context).textTheme.titleMedium),
          // const SizedBox(
          //   width: 33,
          // ),
          Container(
          //  color: Colors.red,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Call Summary",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Background color
                        borderRadius: BorderRadius.circular(12),
                        // Border radius
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.06),
                            offset: Offset(0, 4),
                            blurRadius: 20,
                          ),
                        ], // Box shadow
                      ),
                      child: Text(
                        "Low",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.primaryYellow,
                                fontSize: 15,
                                fontFamily: AppFonts.urbanistSemiBold),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus...",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 16,
                        color: AppColors.grey,
                      ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(AppImages.noteArrow)
        ],
      ),
    );
  }
}
