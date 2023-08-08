import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 60, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.extraLightGrey,
                  radius: 32,
                  child: SvgPicture.asset(AppImages.category),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.lightYellow,
                      radius: 26,
                      child: SvgPicture.asset(AppImages.search),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.lightYellow,
                      radius: 26,
                      child: SvgPicture.asset(AppImages.plusIcon),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "Hello, Shea Lewis",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 34),
            ),
            const SizedBox(height: 8),
            Text(
              "Welcome to your notes",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
            const SizedBox(
              height: 60,
            ),
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
                return  SingleNote(index:index);
              },
              itemCount: 4,
            ))
          ],
        ),
      ),
    );
  }
}
