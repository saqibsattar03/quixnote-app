import 'package:flutter/material.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/widgets/app_button.dart';

class ConnectAccounts extends StatelessWidget {
  const ConnectAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              AppNavigation.pop();
            },
          ),
          title: Text(
        'Connect Accounts',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 30),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Email',
            ),
            const SizedBox(height: 20),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Slack',
            ),
            const SizedBox(height: 20),
            AppButton(
                buttonSize: const Size(double.infinity, 50),
                onPressed: () {},
                buttonTitle: 'Drop box/Drive',
                iconData: Icons.arrow_back_rounded),
            const SizedBox(height: 20),
            AppButton(
                buttonSize: const Size(double.infinity, 50),
                onPressed: () {},
                buttonTitle: 'Evernote',
                iconData: Icons.arrow_back_rounded),
            const SizedBox(height: 20),
            AppButton(
              buttonSize: const Size(double.infinity, 50),
              onPressed: () {},
              buttonTitle: 'Discord',
              iconData: Icons.arrow_downward,
            ),
          ],
        ),
      ),
    );
  }
}
