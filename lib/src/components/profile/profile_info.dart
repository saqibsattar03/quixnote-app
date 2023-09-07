import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/components/sign_up/change_password.dart';
import 'package:quix_note/src/components/sign_up/verify_email.dart';
import 'package:quix_note/src/service/api/profile_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';

import '../../base/nav.dart';
import '../../models/profile/sign_up_model.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    //controllers

    final fullNameController = TextEditingController();
    final countryController = TextEditingController();
    final stateController = TextEditingController();
    final cityController = TextEditingController();

    final api = ProfileApiConfig();

    void clearAllControllers() {
      fullNameController.clear();
      countryController.clear();
      stateController.clear();
      cityController.clear();
    }

    void editProfile() async {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        final userModel = SignUpModel(
          fullName: fullNameController.text,
          country: countryController.text,
          state: stateController.text,
          city: cityController.text,
        );
        await api.editProfile(model: userModel, id: AppData.loggedUserId);
        // clearAllControllers();
        if (!mounted) return;
        Navigator.pop(context);
        AppNavigation.pop();
      } catch (e) {
        ErrorDialog(
          error: e,
        ).show(context);
      }
    }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    const FieldTitle(title: 'Full Name'),
                    const SizedBox(height: 10),
                    AppTextField(
                      textEditingController: fullNameController,
                      hint: 'John Doe',
                      fillColor: AppColors.lightYellow,
                    ),
                    const FieldTitle(title: 'Country'),
                    const SizedBox(height: 10),
                    AppTextField(
                      textEditingController: countryController,
                      hint: 'United States America',
                      fillColor: AppColors.lightYellow,
                    ),
                    const FieldTitle(title: 'City'),
                    const SizedBox(height: 10),
                    AppTextField(
                      textEditingController: stateController,
                      hint: 'New York',
                      fillColor: AppColors.lightYellow,
                    ),
                    const FieldTitle(title: 'State'),
                    const SizedBox(height: 10),
                    AppTextField(
                      textEditingController: cityController,
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
                    onPressed: editProfile,
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const VerifyEmailScreen()),
                    //   );
                    // },
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
