import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/sign_up/privacy_policy.dart';
import 'package:quix_note/src/components/sign_up/terms_conditions.dart';
import 'package:quix_note/src/components/sign_up/verify_email.dart';
import 'package:quix_note/src/models/profile/sign_up_model.dart';
import 'package:quix_note/src/service/api/profile_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/app_utils.dart';

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

  // controllers

  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final api = ProfileApiConfig();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$')
        .hasMatch(value)) {
      return 'Password must be 8 characters long and contain \nat least one uppercase letter, one lowercase letter,\none digit, and one special character.';
    }

    return null;
  }

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        print(userCredential.user?.email);
        final userModel = SignUpModel(
            fullName: _fullNameController.text,
            email: userCredential.user!.email ?? "");
       api.signUpUser(signUpModel: userModel);
        // pop the circular indicator //
        Navigator.pop(context);
      } else {
        // show error message
      }
    } catch (e) {
      print(e.toString());
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
      body: Form(
        // TODO: start from here
        key: _formKey,
        child: Padding(
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
                const FieldTitle(title: 'Full name'),
                const SizedBox(height: 10),
                AppTextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty) {
                      return 'Full Name is required.';
                    }
                    return null;
                  },
                  textEditingController: _fullNameController,
                  fillColor: AppColors.lightYellow,
                  hint: 'Martin',
                  prefix: const Icon(Icons.person),
                ),
                const FieldTitle(title: 'Email'),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: _emailController,
                  textInputAction: TextInputAction.next,
                  validator: AppUtils.email(),
                  keyboardType: TextInputType.emailAddress,
                  hint: 'example@email.com',
                  fillColor: AppColors.lightYellow,
                  prefix: const Icon(
                    Icons.email,
                  ),
                ),
                const FieldTitle(title: 'Password'),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: _passwordController,
                  textInputAction: TextInputAction.next,
                  // validator: validatePassword,
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
                  textEditingController: _confirmPasswordController,
                  // validator: validatePassword,
                  hint: 'Confirm Password',
                  fillColor: AppColors.lightYellow,
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
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    // onPressed: privacyPolicy && termsCondition ? signUp : null,
                    onPressed: (privacyPolicy && termsCondition)
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              signUp();
                            }
                          }
                        : null,
                    // onPressed: () {
                    // AppNavigation.push(const VerifyEmailScreen());
                    // },
                    buttonTitle: 'Create Account',
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
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
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: textTheme.bodyMedium!.copyWith(
          fontSize: 16,
        ),
      ),
    );
  }
}
