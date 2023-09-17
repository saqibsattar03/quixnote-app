import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/service/api/privacy_terms_api_config.dart';
import 'package:quix_note/src/utils/api_errors.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';

import '../../models/privacy/privacy.dart';
import '../../widgets/formatted_date.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions(
      {Key? key,
      required this.callBack,
      required this.isChecked,
      required this.isSignupForm})
      : super(key: key);

  final Function(bool val) callBack;
  final bool isChecked;
  final bool isSignupForm;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  var isLoading = true;
  var isUpdated = false;
  var exception = "";
  var termsAndConditionResponse = <PrivacyTerms>[];
  final api = PrivacyTermsApiConfig();

  ApiError? _error;

  bool get _hasError => _error != null;

  @override
  void initState() {
    super.initState();
    getTermsAndConditionData();
    isUpdated = widget.isChecked;
  }

  Future<void> getTermsAndConditionData() async {
    try {
      termsAndConditionResponse = await api.getTermsAndConditions();
    } catch (e) {
      _error = ApiError.withDioError(e);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final formattedDate = DateFormat.yMd().format(termsAndConditionResponse[0].lastUpdated);
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
                  'Terms & Conditions',
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
              ] else ...[
                if (termsAndConditionResponse.isNotEmpty) ...[
                  FormattedDateWidget(
                    dateTime: termsAndConditionResponse[0].lastUpdated,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: termsAndConditionResponse.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailContainer(
                                title: termsAndConditionResponse[index].clause,
                                subTitle: termsAndConditionResponse[index]
                                    .description,
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
                if (widget.isSignupForm && termsAndConditionResponse.isNotEmpty)
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
