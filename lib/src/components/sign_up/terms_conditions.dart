import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/service/api/privacy_terms_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';

import '../../models/privacy/privacy.dart';
import '../../widgets/formatted_date.dart';


class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isLoading = false;
  String exception = "";
  late List<PrivacyTerms> termsAndConditionResponse;
  final api = PrivacyTermsApiConfig();

  @override
  void initState() {
    super.initState();
    getTermsAndConditionData();
  }


  Future<void> getTermsAndConditionData() async{
    try{
      isLoading = true;
      setState(() {});

      final response = await api.getTermsAndConditions();
      termsAndConditionResponse = response;

      isLoading = false;
      setState(() {});
    }catch(e){
      exception = e.toString();
      isLoading = false;
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final formattedDate = DateFormat.yMd().format(termsAndConditionResponse[0].lastUpdated);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
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
          'Terms & Conditions',
          style: textTheme.titleLarge!.copyWith(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10),

        if(isLoading)
          const CircularProgressIndicator()
        else
          Expanded(
            child: Column(
              children: [
                FormattedDateWidget(dateTime: termsAndConditionResponse[0].lastUpdated),
                // Text(
                //   'Last updated on ${termsAndConditionResponse[0].lastUpdated}',
                //   style: textTheme.bodyMedium!
                //       .copyWith(fontSize: 18, color: AppColors.lightGrey),
                // ),
                const SizedBox(height: 40),
                Expanded(
                    child: ListView.builder(
                      itemCount: termsAndConditionResponse.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailContainer(
                              title: termsAndConditionResponse[index].clause,
                              subTitle: termsAndConditionResponse[index].description,
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



        // DetailContainer(
        //   title: 'Clause 1',
        //   subTitle:
        //       'Lorem ipsum dolor sit amet consectetur. At sit tellus vel tortor egestas velit luctus arcu. Lacus quam aliquam ac massa natoque gravida justo. Neque aliquam potenti leo mi sit lobortis sed. Aliquam ut a ultricies lacus nullam nisl sem. Non accumsan etiam vitae neque sit massa at cras. Donec quisque lacus venenatis lectus aliquam eget.',
        // ),
        // SizedBox(height: 10),
        // DetailContainer(
        //   title: 'Clause 2',
        //   subTitle:
        //       'Lorem ipsum dolor sit amet consectetur. At sit tellus vel tortor egestas velit luctus arcu. Lacus quam aliquam ac massa natoque gravida justo. Neque aliquam potenti leo mi sit lobortis sed. Aliquam ut a ultricies lacus nullam nisl sem. Non accumsan etiam vitae neque sit massa at cras. Donec quisque lacus venenatis lectus aliquam eget.',
        // ),

          ],
        ),
      ),
    );
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



