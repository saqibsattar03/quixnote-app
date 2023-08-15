import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            AppNavigation.pop();
          },
        ),
        actions: [
          SvgPicture.asset(AppImages.profileIcon),
          const SizedBox(width: 30)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Terms & Conditions',
              style: textTheme.titleLarge!.copyWith(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Last updated on 1/12/2021',
              style: textTheme.bodyMedium!
                  .copyWith(fontSize: 18, color: AppColors.lightGrey),
            ),
            const SizedBox(height: 40),
            DetailContainer(
              title: 'Clause 1',
              subTitle:
                  'Lorem ipsum dolor sit amet consectetur. At sit tellus vel tortor egestas velit luctus arcu. Lacus quam aliquam ac massa natoque gravida justo. Neque aliquam potenti leo mi sit lobortis sed. Aliquam ut a ultricies lacus nullam nisl sem. Non accumsan etiam vitae neque sit massa at cras. Donec quisque lacus venenatis lectus aliquam eget.',
            ),
            SizedBox(height: 10),
            DetailContainer(
              title: 'Clause 2',
              subTitle:
                  'Lorem ipsum dolor sit amet consectetur. At sit tellus vel tortor egestas velit luctus arcu. Lacus quam aliquam ac massa natoque gravida justo. Neque aliquam potenti leo mi sit lobortis sed. Aliquam ut a ultricies lacus nullam nisl sem. Non accumsan etiam vitae neque sit massa at cras. Donec quisque lacus venenatis lectus aliquam eget.',
            ),
            const SizedBox(height: 40),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Agree',
            ),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge!.copyWith(
            fontSize: 24,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subTitle,
          style: textTheme.bodyMedium!.copyWith(
              fontSize: 14, color: AppColors.lightGrey, letterSpacing: 0.2),
        )
      ],
    );
  }
}
