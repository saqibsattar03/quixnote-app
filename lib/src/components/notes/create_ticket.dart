import 'package:flutter/material.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

import '../../utils/app_fonts.dart';
import '../../widgets/app_button.dart';

class CreateTicket extends StatelessWidget {
  const CreateTicket({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Create a Ticket",
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
      body: Padding(
        padding: const EdgeInsets.only(top: 65, left: 29, right: 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'What’s your problem?',
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 15, fontFamily: AppFonts.urbanistSemiBold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                const AppTextField(
                  maxLines: 5,
                  fillColor: AppColors.lightYellow,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  'Attach File',
                  style: textTheme.bodyMedium!.copyWith(
                      fontSize: 15, fontFamily: AppFonts.urbanistSemiBold),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const VerifyEmailScreen()),
                      // );
                    },
                    buttonTitle: 'Submit',
                  ),
                ),
                const SizedBox(height: 40),
              ],
            )
          ],
        ),
      ),
    );
  }
}
