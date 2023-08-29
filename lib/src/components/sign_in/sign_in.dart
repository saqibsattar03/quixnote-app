import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/sign_up/reset_password_email.dart';
import 'package:quix_note/src/components/sign_up/verify_email.dart';
import 'package:quix_note/src/models/profile/sign_in_model.dart';
import 'package:quix_note/src/models/profile/sign_up_model.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_utils.dart';
import 'package:quix_note/src/utils/error_dialog.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api/profile_api_config.dart';

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

  //controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final api = ProfileApiConfig();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      String? idToken = await userCredential.user?.getIdToken();
      print("idtoken ${idToken}");

      final response = await api.getUserUsingIdToken(idToken: idToken!);

      if (response == 'true') {
        final userModel =
            SignInModel(email: userCredential.user!.email, password: null);
        final res = await api.signInUser(signInModel: userModel);
        print("access token ${res.accessToken}");
        AppData.saveAccessToken(res.accessToken);
      }
      if (!mounted) return;
      Navigator.pop(context);
      AppNavigation.push(const NotesPage());
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      ErrorDialog(error: e).show(context);
      print(
          "error ${e.toString()}------------------------------------------------------------------------->");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  AppNavigation.pop();
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
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
                        AppTextField(
                          hint: 'example@email.com',
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: _emailController,
                          validator: AppUtils.email(),
                          fillColor: AppColors.lightYellow,
                          prefix: const Icon(
                            Icons.email,
                          ),
                        ),
                        const FieldTitle(title: 'Password'),
                        const SizedBox(height: 10),
                        AppTextField(
                          hint: 'password',
                          textEditingController: _passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Password is required.';
                            }
                            return null;
                          },
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
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                      child: AppButton(
                        buttonSize: const Size(double.infinity, 50),

                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signIn();
                          }
                        },
                        // onPressed: () {
                        //   AppNavigation.push(const NotesPage());
                        // },
                        buttonTitle: 'Login',
                      ),
                    ),
                    const SizedBox(height: 40)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
