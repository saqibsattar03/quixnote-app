import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:quix_note/src/components/sign_up/auth/success.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_fonts.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Verify your email',
              style: textTheme.titleLarge!.copyWith(
                fontSize: 34,
              ),
            ),
            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'We already sent a code to your email ',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGrey,
                  ),
                  children: const [
                    TextSpan(
                      text: 'jhon@*****.com',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey),
                    ),
                    TextSpan(
                      text:
                          ', please input below to confirm your email address',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            OtpPinField(
              key: _otpPinFieldController,
              autoFillEnable: false,
              textInputAction: TextInputAction.done,
              onSubmit: (text) {
                print('Entered pin is $text');
              },
              onChange: (text) {
                print('Enter on change pin is $text');
              },
              onCodeChanged: (code) {
                print('onCodeChanged  is $code');
              },
              otpPinFieldStyle: const OtpPinFieldStyle(
                defaultFieldBorderColor: Colors.black12,
                activeFieldBorderColor: Colors.black12,
                defaultFieldBackgroundColor: Colors.white12,
                activeFieldBackgroundColor: Colors.white12,
                filledFieldBackgroundColor: AppColors.lightYellow,
                filledFieldBorderColor: AppColors.lightYellow,
                fieldBorderRadius: 14,
                fieldPadding: 15.0,
              ),
              maxLength: 5,
              showCursor: true,
              cursorColor: Colors.indigo,
              showDefaultKeyboard: true,
              cursorWidth: 3,
              mainAxisAlignment: MainAxisAlignment.center,
              otpPinFieldDecoration:
                  OtpPinFieldDecoration.defaultPinBoxDecoration,
            ),
            const SizedBox(
              height: 38,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.stopwatchIcon),
                const SizedBox(
                  width: 8,
                ),
                const Text('00:59')
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            Align(
              alignment: Alignment.center,
              child: AppButton(
                  buttonSize: const Size(192, 53),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessPage()),
                    );
                  },
                  radius: 40,
                  buttonTitle: "Confirm Now"),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              "Resend Code",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 13,
                  fontFamily: AppFonts.urbanistSemiBold,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
      ),
    );
  }
}
