import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/create_ticket.dart';
import 'package:quix_note/src/models/faq/faq_model.dart';
import 'package:quix_note/src/utils/app_fonts.dart';

import '../../service/api/faq_api_config.dart';
import '../../utils/api_errors.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/app_button.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  var isLoading = true;
  ApiError? _error;
  bool get _hasError => _error != null;

  final api = FAQApiConfig();
  var faqModelResponse = <FaqModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFaqs();
  }

  void getFaqs() async {
    try {
      faqModelResponse = await api.getFaq();
    } catch (e) {
      _error = ApiError.withDioError(e);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            AppNavigation.pop();
          },
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.extraLightGrey,
                  radius: 60,
                  child: SvgPicture.asset(AppImages.questionMarkIcon),
                ),
                const SizedBox(
                  height: 34,
                ),
                Text(
                  "Frequently asked Questions",
                  style: textTheme.titleLarge!.copyWith(fontSize: 28),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _hasError
                    ? Center(child: Text(_error?.description ?? ''))
                    : Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: faqModelResponse.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 18),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ExpansionTile(
                                      title: Text(
                                        faqModelResponse[index].question,
                                        style:
                                            textTheme.titleMedium!.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily:
                                              AppFonts.urbanistSemiBold,
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              top: 18,
                                              bottom:
                                                  8), // Add left padding
                                          child: Text(
                                            faqModelResponse[index].answer,
                                            style: textTheme.titleMedium!
                                                .copyWith(
                                              fontSize: 16,
                                              fontFamily:
                                                  AppFonts.urbanistSemiBold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Need More Help?',
                  style: textTheme.bodyMedium!.copyWith(
                      fontSize: 15, fontFamily: AppFonts.urbanistSemiBold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: AppButton(
                    buttonSize: const Size(double.infinity, 50),
                    onPressed: () {
                      AppNavigation.push(const CreateTicket());
                    },
                    buttonTitle: 'Contact Us',
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
    );
  }
}
