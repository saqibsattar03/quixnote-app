import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/components/on_boarding/widgets/on_boarding_layout.dart';
import 'package:quix_note/src/components/sign_up/social_auth.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../base/data.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final controller = PageController();
  int currentPage = 0;
  bool isLastPage = false;
  int step = 0;
  final List<double> _animationValues = [
    0.3,
    0.7,
    1.0,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void pressToAnimate({int index = -1}) {
    setState(() {
      if (step >= _animationValues.length - 1) {
        if (index != -1) {
          step = index;
          isLastPage = false;
        } else {
          // isLastPage = true;
        }
      } else {
        if (index == -1) {
          step++;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20 + media.padding.top, 20, 20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics:const NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: (index) {
                  if (index == 2) {
                    isLastPage = true;
                    AppData.setOnBoardingValue(true);
                    setState(() {});
                  }
                },
                children: [
                  BoardingLayout(
                    urlImage: AppImages.onBoardingOne,
                    title: "Welcome to Quix Notes!",
                    subtitle:
                        "We're thrilled to have you join our community of Quix Notes enthusiasts. Get ready to embark on a seamless journey of Quix Notes Main Features right at your fingertips.",
                    controller: controller
                  ),
                  BoardingLayout(
                    urlImage: AppImages.onBoardingTwo,
                    title: "Engage and Connect",
                    subtitle:
                        "Connect with fellow users who share your interests. Join [Community/Group Names] to discuss your passions, exchange ideas, and engage in meaningful conversations.",
                    controller: controller,
                  ),
                  BoardingLayout(
                    urlImage: AppImages.onBoardingThree,
                    title: "Support",
                    subtitle:
                        "Have questions or feedback? Our [Support Team/Help Center] is here to assist you. Don't hesitate to reach out whenever you need assistance.",
                    controller: controller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(48, 0, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    spacing: 10,
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: AppColors.darkTeal.withOpacity(0.3),
                    activeDotColor: AppColors.darkTeal,
                  ),
                  onDotClicked: (index) => {
                        controller.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        pressToAnimate(index: index)
                      }),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: _animationValues[step > 0 ? step - 1 : 0],
                  end: _animationValues[step],
                ),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 1.0,
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(
                              value: value,
                              backgroundColor:
                                  AppColors.darkTeal.withOpacity(0.1),
                              strokeWidth: 2.5,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.darkTeal,
                              ),
                            ),
                          ),
                        ),
                        FloatingActionButton.small(
                          onPressed: () {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            if (!isLastPage) {
                              pressToAnimate();
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SocialAuth()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                          backgroundColor: AppColors.primaryYellow,
                          shape: const CircleBorder(),
                          child: SvgPicture.asset(AppImages.rightArrow),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
