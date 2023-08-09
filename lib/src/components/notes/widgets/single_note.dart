import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_fonts.dart';
import 'package:quix_note/src/utils/app_images.dart';

class SingleNote extends StatelessWidget {
  const SingleNote({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          if (index == 0) ...[
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: AppColors.dividerGrey,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("01/", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Call Summary",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 24),
                        ),
                        // const SizedBox(
                        //   width: 11,
                        // ),
                        Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus...",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
          if (index == 3) ...[
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
              color: AppColors.dividerGrey,
            )
          ]
        ],
      ),
    );
  }
}
