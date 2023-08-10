import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';

import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../sign_in/sign_in.dart';
import '../sign_up/auth/verify_email.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Info",
          style: textTheme.titleLarge!.copyWith(fontSize: 22),
        ),
        leading: IconButton(
          // Add a back button
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 135,
                width: 135,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      AppImages.avatarFrame,
                      height: 127,
                      width: 127,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.darkTeal,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkTeal.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(-3, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(AppImages.editIcon),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 45,),
                    FieldTitle(title: 'Full Name'),
                    SizedBox(height: 10),
                    AppTextField(
                      hint: 'John Doe',
                      fillColor: AppColors.lightYellow,
                    ),
                    FieldTitle(title: 'Country'),
                    SizedBox(height: 10),
                    AppTextField(
                      hint: 'United States America',
                      fillColor: AppColors.lightYellow,
                    ),
                    FieldTitle(title: 'City'),
                    SizedBox(height: 10),
                    AppTextField(
                      hint: 'New York',
                      fillColor: AppColors.lightYellow,
                    ),
                    FieldTitle(title: 'State'),
                    SizedBox(height: 10),
                    AppTextField(
                      hint: 'Great street 01',
                      fillColor: AppColors.lightYellow,
                    ),
                  ],
                ),
              ),
              Column(children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyEmailScreen()),
                      );
                    },
                    buttonTitle: 'Next',
                  ),
                ),
                const SizedBox(height: 40)
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
