import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/sign_up/privacy_policy.dart';
import 'package:quix_note/src/components/sign_up/terms_conditions.dart';
import 'package:quix_note/src/components/sign_up/verify_email.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Get Started',
                  style: textTheme.titleLarge!.copyWith(
                    fontSize: 34,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Create an Account to continue',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const FieldTitle(title: 'Name'),
              const SizedBox(height: 10),
              const AppTextField(
                fillColor: AppColors.lightYellow,
                hint: 'Martin',
                prefix: Icon(Icons.person),
              ),
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
              const FieldTitle(title: 'Confirm Password'),
              const SizedBox(height: 10),
              AppTextField(
                hint: 'Confirm Password',
                fillColor: AppColors.lightYellow,
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
                prefix: const Icon(Icons.lock),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      termsCondition = !termsCondition;
                      setState(() {});
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        color: termsCondition
                            ? AppColors.darkTeal
                            : Colors.transparent,
                      ),
                      child: termsCondition
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'By signing up I agree with ',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditions()),
                                );
                              },
                            text: 'Terms',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditions()),
                                );
                              },
                            text: 'Conditions',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      privacyPolicy = !privacyPolicy;
                      setState(() {});
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        color: privacyPolicy
                            ? AppColors.darkTeal
                            : Colors.transparent,
                      ),
                      child: privacyPolicy
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 10,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'By signing up I agree with ',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicy()),
                                );
                              },
                            text: 'Privacy',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PrivacyPolicy()));
                              },
                            text: 'Policy',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AppButton(
                  buttonSize: const Size(double.infinity, 50),
                  onPressed: () {
                    AppNavigation.push(const VerifyEmailScreen());
                  },
                  buttonTitle: 'Create Account',
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
