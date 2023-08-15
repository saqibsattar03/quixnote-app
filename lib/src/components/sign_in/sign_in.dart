import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/sign_up/reset_password_email.dart';
import 'package:quix_note/src/components/sign_up/verify_email.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignIn> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Hi, Welcome Back',
                    style: textTheme.titleLarge!.copyWith(
                      fontSize: 34,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login to your account',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldTitle(title: 'Email'),
                    const SizedBox(height: 10),
                    const AppTextField(
                      hint: 'example@email.com',
                      fillColor: AppColors.lightYellow,
                      prefix: Icon(
                        Icons.email,
                      ),
                    ),
                    const FieldTitle(title: 'Password'),
                    const SizedBox(height: 10),
                    AppTextField(
                      hint: 'password',
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          AppNavigation.push(const ResetPasswordEmail());
                        },
                        child: Text(
                          'Forgot Password?',
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    onPressed: () {
                      AppNavigation.push(const NotesPage());
                    },
                    buttonTitle: 'Login',
                  ),
                ),
                const SizedBox(height: 40)
              ],
            )
          ],
        ),
      ),
    );
  }
}
