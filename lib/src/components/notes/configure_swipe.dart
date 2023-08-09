import 'package:flutter/material.dart';
import 'package:quix_note/src/widgets/app_button.dart';

class ConfigureSwipe extends StatelessWidget {
  const ConfigureSwipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configure swipe',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 30),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Swip Up',
              iconData: Icons.arrow_upward,
            ),
            const SizedBox(height: 20),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Swip Up',
              iconData: Icons.arrow_forward_rounded,
            ),
            const SizedBox(height: 20),
            AppButton(
                buttonSize: const Size(double.infinity, 50),
                onPressed: () {},
                buttonTitle: 'Swip Up',
                iconData: Icons.arrow_back_rounded),
            const SizedBox(height: 20),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Swip Up',
              iconData: Icons.arrow_downward,
            ),
          ],
        ),
      ),
    );
  }
}
