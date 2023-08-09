import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

class SearchNotes extends StatelessWidget {
  const SearchNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcfbfc),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.lightYellow,
                    child: SizedBox(
                      height: 20,
                      width: 30,
                      child: SvgPicture.asset(
                        AppImages.filterIcon,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
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
                  return SingleNote(index: index);
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
