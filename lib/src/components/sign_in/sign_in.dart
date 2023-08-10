import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/components/sign_up/auth/privacy_policy.dart';
import 'package:quix_note/src/components/sign_up/auth/terms_conditions.dart';
import 'package:quix_note/src/components/sign_up/auth/verify_email.dart';
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
              ],
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
                  child: Text(
                    'Forgot Password?',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const VerifyEmailScreen()),
                      );
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
