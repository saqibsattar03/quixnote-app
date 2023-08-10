import 'package:flutter/material.dart';
import 'package:quix_note/src/components/notes/notes_page.dart';
import 'package:quix_note/src/components/sign_up/create_account_screen.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/social_media_button.dart';

class SocialAuthSignIn extends StatelessWidget {
  const SocialAuthSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 50, top: 120, right: 20, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 50),
                  SocialMediaButton(
                    onTap: () {},
                    title: 'Login with Google',
                    assetIcon: AppImages.googleSvgIcon,
                  ),
                  const SizedBox(height: 15),
                  SocialMediaButton(
                    onTap: () {},
                    title: 'Login with Apple ID',
                    assetIcon: AppImages.appleSvgIcon,
                  ),
                  const SizedBox(height: 15),
                  SocialMediaButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccountScreen()),
                      );
                    },
                    title: 'Login with Email',
                    assetIcon: AppImages.gmailSvgIcon,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Don’t have an account?',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotesPage()),
                      );
                    },
                    buttonTitle: 'Sign Up',
                    buttonSize: const Size(double.infinity, 46),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
