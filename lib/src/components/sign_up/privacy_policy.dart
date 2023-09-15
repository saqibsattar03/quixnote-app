import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/models/privacy/privacy.dart';
import 'package:quix_note/src/service/api/privacy_terms_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/formatted_date.dart';

import '../../utils/api_errors.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy(
      {Key? key,
      required this.callBack,
      required this.isChecked,
      required this.isSignupForm})
      : super(key: key);

  final Function(bool val) callBack;
  final bool isChecked;
  final bool isSignupForm;

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var isLoading = true;
  var isUpdated = false;
  var exception = '';
  late DateTime formattedDate;
  late List<PrivacyTerms> privacyTermsResponse;
  final api = PrivacyTermsApiConfig();
  ApiError? _error;
  bool get _hasError => _error != null;

  @override
  void initState() {
    super.initState();
    getPrivacyData();
    isUpdated = widget.isChecked;
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
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Privacy Policy',
                  style: textTheme.titleLarge!.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
              if (isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_hasError) ...[
                Expanded(child: Center(child: Text(_error?.description ?? ''))),
              ]
              else ...[
                if (privacyTermsResponse.isNotEmpty) ...[
                  FormattedDateWidget(
                    dateTime: privacyTermsResponse[0].lastUpdated,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: privacyTermsResponse.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailContainer(
                                title: privacyTermsResponse[index].clause,
                                subTitle: privacyTermsResponse[index].description,
                                index: index,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ] else
                  Expanded(
                    child: Center(
                      child: Text(
                        'No Privacy policy defined yet!',
                        style: textTheme.titleLarge!.copyWith(
                          fontSize: 14,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                if (widget.isSignupForm && privacyTermsResponse.isNotEmpty)
                  AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    onPressed: () {
                      widget.callBack(!widget.isChecked);
                      setState(() {
                        isUpdated = !isUpdated;
                      });
                    },
                    buttonTitle: isUpdated ? 'Disagree' : 'Agree',
                  ),
                const SizedBox(height: 40),
              ],
            ],
          )),
    );
  }

  Future<void> getPrivacyData() async {
    try {
      privacyTermsResponse =  await api.getPrivacyPolicy();
    }
    catch (e) {
      _error = ApiError.withDioError(e);
    }
    isLoading = false;
    setState(() {});
  }
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.index,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            "${index + 1}.",
            style: textTheme.titleLarge!.copyWith(
              fontSize: 22,
              color: AppColors.darkGrey,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            children: [
              Column(
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
                        fontSize: 14,
                        color: AppColors.lightGrey,
                        letterSpacing: 0.2),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
