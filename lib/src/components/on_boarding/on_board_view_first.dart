import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/components/home/home_page.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_fonts.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const style = TextStyle(
    color: AppColors.darkTeal,
    fontSize: 29,
    fontFamily: AppFonts.urbanistSemiBold);

class OnBoardViewOne extends StatefulWidget {
  const OnBoardViewOne({super.key});

  @override
  State<OnBoardViewOne> createState() => _OnBoardViewOneState();
}

class _OnBoardViewOneState extends State<OnBoardViewOne> {
  final controller = PageController();
  bool isLastPage = false;
  int step = 0;
  final List<double> _animationValues = [
    0.3,
    0.7,
    1.0,
  ];

  void pressToAnimate({int index = -1}) {
    print('Index => $index');
    setState(() {
      if (step >= _animationValues.length - 1) {
        if (index != -1) {
          step = index;
          isLastPage = false;
        } else {
          isLastPage = true;
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

  Widget buildPage(
          {required String urlImage,
          required String title,
          required String subtitle}) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                controller.jumpToPage(2);
              },
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                        fontSize: 18, // Set the font size of the text
                        fontFamily:
                            AppFonts.gilroyMedium // Set the color of the text
                        ),
                  ),
                  foregroundColor:
                      MaterialStateProperty.all(AppColors.lightGrey)),
              child: const Text('Skip'),
            ),
            const SizedBox(
              height: 90,
            ),
            SvgPicture.asset(urlImage),
            const SizedBox(
              height: 104,
            ),
            Text(
              title,
              style: style,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 250,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.darkGrey, fontSize: 17),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20+media.padding.top, 20, 20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  buildPage(
                    urlImage: AppImages.onBoardingOne,
                    title: "Lorem Ipsum Dolor",
                    subtitle:
                        "Lorem ipsum dolor sit amet, consetetur  sadipscing elitr",
                  ),
                  buildPage(
                    urlImage: AppImages.onBoardingTwo,
                    title: "Lorem Ipsum Dolor",
                    subtitle:
                        "Lorem ipsum dolor sit amet, consetetur  sadipscing elitr",
                  ),
                  buildPage(
                    urlImage: AppImages.onBoardingThree,
                    title: "Lorem Ipsum Dolor",
                    subtitle:
                        "Lorem ipsum dolor sit amet, consetetur  sadipscing elitr",
                  )
                ],
              ),
            ),
            ///
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(48, 0, 16, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  spacing: 10,
                  dotHeight: 12,
                  dotWidth: 12,
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
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 1.0,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: value,
                          backgroundColor: AppColors.darkTeal.withOpacity(0.1),
                          strokeWidth: 6,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.darkTeal,
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        if (!isLastPage) {
                          pressToAnimate();
                        }
                      },
                      backgroundColor: AppColors.primaryYellow,
                      child: SvgPicture.asset(AppImages.rightArrow),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
