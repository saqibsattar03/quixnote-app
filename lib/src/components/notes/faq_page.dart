import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/create_ticket.dart';
import 'package:quix_note/src/utils/app_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../widgets/app_button.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.extraLightGrey,
                radius: 60,
                child: SvgPicture.asset(AppImages.questionMarkIcon),
              ),
              const SizedBox(
                height: 34,
              ),
              Text(
                "Frequently asked Questions",
                style: textTheme.titleLarge!.copyWith(fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 28),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.dividerGrey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Does Quix Note Lorem Ipsum Dolor Sit ",
                            style: textTheme.titleMedium!.copyWith(
                                fontSize: 16,
                                fontFamily: AppFonts.urbanistSemiBold),
                          ),
                          SvgPicture.asset(AppImages.chevronRight)
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  // Adjust the height as needed
                  itemCount: 4,
                ),
              ),
              Text(
                'Need More Help?',
                style: textTheme.bodyMedium!.copyWith(
                    fontSize: 15, fontFamily: AppFonts.urbanistSemiBold),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: AppButton(
                  buttonSize: const Size(double.infinity, 50),
                  onPressed: () {
                    AppNavigation.push(const CreateTicket());
                  },
                  buttonTitle: 'Contact Us',
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
