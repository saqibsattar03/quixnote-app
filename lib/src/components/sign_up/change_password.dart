import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/sign_up/reset_password_email.dart';

import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_alert_dialog.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

import '../../service/api/profile_api_config.dart';
import '../../utils/error_dialog.dart';
import 'verify_email.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePassword> {
  bool obscure = true;
  bool obscure1 = true;
  bool obscure2 = true;

  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  final _focusNode = FocusNode();

  //controllers

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final api = ProfileApiConfig();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (!RegExp(r'^.{8}$').hasMatch(value)) {
      return 'Password must be 8 characters long.';
    }

    return null;
  }


  String? matchPassword(String? value) {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  void changePassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      var user = FirebaseAuth.instance.currentUser!;
      var cred = EmailAuthProvider.credential(
          email: user.email!, password: _oldPasswordController.text);
      var authenticated = await user.reauthenticateWithCredential(cred);
      if (_newPasswordController.text == _confirmPasswordController.text) {
        await user.updatePassword(_newPasswordController.text).then((_) => {
              Navigator.pop(context),
              AppNavigation.push(const NotesPage()),
              showDialog(
                context: context,
                builder: (context) => const AppAlertDialog(
                  message: 'Password changed successfully',
                ),
              ),
            });
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      const ErrorDialog(error: "Old Password is not correct").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            AppNavigation.pop();
          },
        ),
      ),
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
                      'Change Password',
                      style: textTheme.titleLarge!.copyWith(
                        fontSize: 34,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter in a new password',
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldTitle(title: 'Confirm your password'),
                    const SizedBox(height: 10),
                    AppTextField(
                      textEditingController: _oldPasswordController,
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
                    const FieldTitle(title: 'New password'),
                    const SizedBox(height: 10),
                    FocusScope(
                      child: Focus(
                        focusNode: _focusNode,
                        onFocusChange: (focus) {
                          if (_newPasswordController.text.isEmpty) {
                            return;
                          }
                          _autoValidateMode = AutovalidateMode.always;
                          setState(() {});
                        },
                        child: AppTextField(
                          textEditingController: _newPasswordController,
                          textInputAction: TextInputAction.next,
                          validator: validatePassword,
                          hint: '*****************',
                          obscure: obscure1,
                          suffix: IconButton(
                            icon: Icon(
                              obscure1 ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              obscure1 = !obscure1;
                              setState(() {});
                            },
                          ),
                          fillColor: AppColors.lightYellow,
                          prefix: const Icon(Icons.lock),
                        ),
                      ),
                    ),
                    const FieldTitle(title: 'Confirm new password'),
                    const SizedBox(height: 10),
                    AppTextField(
                      textEditingController: _confirmPasswordController,
                      validator: matchPassword,
                      hint: '*****************',
                      obscure: obscure2,
                      suffix: IconButton(
                        icon: Icon(
                          obscure2 ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          obscure2 = !obscure2;
                          setState(() {});
                        },
                      ),
                      fillColor: AppColors.lightYellow,
                      prefix: const Icon(Icons.lock),
                    ),
                  ],
                ),
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
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          _autoValidateMode = AutovalidateMode.always;
                          setState(() {});
                          return;
                        }
                        changePassword();
                      },
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
