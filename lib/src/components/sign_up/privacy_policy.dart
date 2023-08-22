import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/models/privacy/privacy.dart';
import 'package:quix_note/src/service/api/privacy_terms_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/formatted_date.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isLoading = false;
  String exception = '';
  late DateTime formattedDate;
  late List<PrivacyTerms> privacyTermsResponse;
  final api = PrivacyTermsApiConfig();

  @override
  void initState() {
    super.initState();
    getPrivacyData();
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
        actions: [
          SvgPicture.asset(AppImages.profileIcon),
          const SizedBox(width: 30)
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Privacy Policy',
                style: textTheme.titleLarge!.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),

              if (isLoading)
                const CircularProgressIndicator()
              else
                Expanded(
                  child: Column(
                    children: [
                      FormattedDateWidget(dateTime: privacyTermsResponse[0].lastUpdated),
                      const SizedBox(height: 40),
                      Expanded(
                          child: ListView.builder(
                        itemCount: privacyTermsResponse.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailContainer(
                                title: privacyTermsResponse[index].clause,
                                subTitle: privacyTermsResponse[index].description,
                              ),
                            ],
                          );
                        },
                      )),
                     // const SizedBox(height: 40),
                      AppButton(
                        buttonSize: const Size(double.infinity, 50),
                        onPressed: () {},
                        buttonTitle: 'Agree',
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),

            ],
          )

          //   SingleChildScrollView(
          // child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     const SizedBox(height: 20),
          //     Text(
          //       'Privcy Policy',
          //       style: textTheme.titleLarge!.copyWith(
          //         fontSize: 24,
          //       ),
          //     ),
          //     const SizedBox(height: 10),
          //     Text(
          //       'Last updated on 1/12/2021',
          //       style: textTheme.bodyMedium!
          //           .copyWith(fontSize: 18, color: AppColors.lightGrey),
          //     ),
          //     const SizedBox(height: 40),
          //     DetailContainer(
          //       title: 'Clause 1',
          //       subTitle:
          //       'Lorem ipsum dolor sit amet consectetur. At sit tellus vel tortor egestas velit luctus arcu. Lacus quam aliquam ac massa natoque gravida justo. Neque aliquam potenti leo mi sit lobortis sed. Aliquam ut a ultricies lacus nullam nisl sem. Non accumsan etiam vitae neque sit massa at cras. Donec quisque lacus venenatis lectus aliquam eget.',
          //     ),
          //     SizedBox(height: 10),
          //     DetailContainer(
          //       title: 'Clause 2',
          //       subTitle:
          //       'Lorem ipsum dolor sit amet consectetur. At sit tellus vel tortor egestas velit luctus arcu. Lacus quam aliquam ac massa natoque gravida justo. Neque aliquam potenti leo mi sit lobortis sed. Aliquam ut a ultricies lacus nullam nisl sem. Non accumsan etiam vitae neque sit massa at cras. Donec quisque lacus venenatis lectus aliquam eget.',
          //     ),
          //     const SizedBox(height: 40),
          //     AppButton(
          //       buttonSize: const Size(double.infinity, 50),
          //       onPressed: () {},
          //       buttonTitle: 'Agree',
          //     ),
          //     const SizedBox(height: 40),
          //   ],
          // )),
          ),
    );
  }

  Future<void> getPrivacyData() async {
    try {
      isLoading = true;
      setState(() {});

      final response = await api.getPrivacyPolicy();
      privacyTermsResponse = response;
      isLoading = false;
      setState(() {});
    } catch (e) {
      exception = e.toString();
      isLoading = false;
      setState(() {});
    }
  }
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleLarge!.copyWith(
            fontSize: 24,
            color: AppColors.darkGrey,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subTitle,
          style: textTheme.bodyMedium!.copyWith(
              fontSize: 14, color: AppColors.lightGrey, letterSpacing: 0.2),
        )
      ],
    );
  }
}
