import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/components/sign_up/verify_email.dart';

import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_alert_dialog.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPassword> {
  bool obscure = true;
  bool obscure1 = true;
  bool termsCondition = false;
  bool privacyPolicy = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(AppImages.changePassword),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Reset your Password',
                      style: textTheme.titleLarge!.copyWith(
                        fontSize: 34,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter in a New Password',
                      style: textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldTitle(title: 'New password'),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: '*****************',
                    obscure: obscure,
                    suffix: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        obscure = !obscure;
                        setState(() {});
                      },
                    ),
                    fillColor: AppColors.lightYellow,
                    prefix: const Icon(Icons.lock),
                  ),
                  const FieldTitle(title: 'Confirm new password'),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: '*****************',
                    obscure: obscure,
                    suffix: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        obscure = !obscure;
                        setState(() {});
                      },
                    ),
                    fillColor: AppColors.lightYellow,
                    prefix: const Icon(Icons.lock),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AppButton(
                      buttonSize: const Size(double.infinity, 50),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const AppAlertDialog(
                          message: 'Password is Changed',
                        ),
                      ),
                      buttonTitle: 'Save',
                    ),
                  ),
                  const SizedBox(height: 40)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FieldTitle extends StatelessWidget {
  const FieldTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: textTheme.bodyMedium!.copyWith(
        fontSize: 16,
      ),
    );
  }
}
