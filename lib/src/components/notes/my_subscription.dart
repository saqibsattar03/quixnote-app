import 'package:flutter/material.dart';
import 'package:quix_note/src/utils/app_colors.dart';

class MySubscription extends StatelessWidget {
  const MySubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
              AppColors.lightYellow,
              AppColors.lightYellow,
              Colors.white,
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            children: [
              Text(
                'My Subscription',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Access to all lorem ipsum dolor sit amet consectetur. Sem a arcu facilisis eu. Dui blandit condimentum.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              const SubscriptionItem(),
              const SizedBox(height: 20),
              const SubscriptionItem(),
              const SizedBox(height: 20),
              const SubscriptionItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  const SubscriptionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Free Trial',
              style: textTheme.bodyMedium!
                  .copyWith(fontSize: 13, fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$00.0 / 90 DAYS',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Ends on 1 Jan 2024',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
