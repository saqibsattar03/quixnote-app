import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/note_detail.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_fonts.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

import '../../widgets/app_circular_button.dart';

class SearchNotes extends StatelessWidget {
  const SearchNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcfbfc),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 18,
                        )),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: SizedBox(
                      height: 70,
                      child: AppTextField(
                        label: 'Search',
                        fillColor: Colors.white,
                        prefix: Icon(Icons.search),
                        borderRadius: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AppCircularButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 456,
                            child: Stack(
                              children: [
                                const Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    ApplyFiltersSheet(),
                                  ],
                                ),
                                Positioned(
                                  top: 25,
                                  right: MediaQuery.sizeOf(context).width * .5 -
                                      10,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40.0)),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Icon(Icons.clear),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    color: AppColors.lightYellow,
                    svg: SvgPicture.asset(
                      AppImages.filterIcon,
                    ),
                    height: 50,
                    width: 50,
                  )
                ],
              ),
              const SizedBox(height: 50),
              Expanded(
                  child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: AppColors.dividerGrey,
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        AppNavigation.push(const NoteDetail());
                      },
                  );

                      // child: SingleNote(index: index));
                },
                itemCount: 4,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ApplyFiltersSheet extends StatefulWidget {
  const ApplyFiltersSheet({Key? key}) : super(key: key);

  @override
  State<ApplyFiltersSheet> createState() => _ApplyFiltersSheetState();
}

class _ApplyFiltersSheetState extends State<ApplyFiltersSheet> {
  int selectedDate = 0;
  int selectedPriority = 0;
  final priority = ['Low', 'High', 'Urgent'];
  final date = [
    'Today',
    'Last Week',
    'Last Month',
    'Last Year',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: textTheme.titleLarge!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Reset',
                  style: textTheme.displayMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Date',
              style: textTheme.displayMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              children: date.map((e) {
                int index = date.indexOf(e);
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      selectedDate = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: selectedDate == index
                            ? const Color(0xfff1c186).withOpacity(0.3)
                            : Colors.white,
                        border: Border.all(
                            color: selectedDate == index
                                ? const Color(0xfff1c186).withOpacity(0.3)
                                : AppColors.lightGrey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        e,
                        style: textTheme.displayMedium!.copyWith(
                            fontSize: 15,
                            fontFamily: selectedDate == index
                                ? AppFonts.urbanistSemiBold
                                : AppFonts.urbanistRegular,
                            color: selectedDate == index
                                ? AppColors.darkTeal
                                : AppColors.lightGrey),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Text(
              'Priority',
              style: textTheme.displayMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: priority.map((e) {
                int index = priority.indexOf(e);
                return InkWell(
                  onTap: () {
                    selectedPriority = index;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: selectedPriority == index
                            ? const Color(0xfff1c186).withOpacity(0.3)
                            : Colors.white,
                        border: Border.all(
                            color: selectedPriority == index
                                ? const Color(0xfff1c186).withOpacity(0.3)
                                : AppColors.lightGrey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        e,
                        style: textTheme.displayMedium!.copyWith(
                            fontSize: 15,
                            fontFamily: selectedPriority == index
                                ? AppFonts.urbanistSemiBold
                                : AppFonts.urbanistRegular,
                            color: selectedPriority == index
                                ? AppColors.darkTeal
                                : AppColors.lightGrey),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            AppButton(onPressed: () {}, buttonTitle: 'Apply')
          ],
        ),
      ),
    );
  }
}
