import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/components/notes/configure_swipe.dart';
import 'package:quix_note/src/components/notes/search_notes.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 60, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.extraLightGrey,
                    radius: 32,
                    child: SvgPicture.asset(AppImages.category),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchNotes()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.lightYellow,
                        radius: 26,
                        child: SvgPicture.asset(AppImages.search),
                      ),
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
              style: textTheme.titleLarge!.copyWith(fontSize: 34),
            ),
            const SizedBox(height: 8),
            Text(
              "Welcome to your notes",
              style: textTheme.titleMedium!.copyWith(),
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
                return SingleNote(index: index);
              },
              itemCount: 4,
            ))
          ],
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          width: double.infinity,
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            //  width: double.infinity,
            color: AppColors.lightYellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40))),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 26,
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'Shea Lewis',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Seattle,Washington',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DrawerItemTitle(title: 'Change Password'),
                        const DrawerItemTitle(title: 'Connect Account'),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ConfigureSwipe()),
                            );
                          },
                          child:
                              const DrawerItemTitle(title: 'Configure swipe'),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const DrawerItemTitle(title: 'Notifications'),
                            const SizedBox(width: 20),
                            SizedBox(
                              height: 30,
                              width: 40,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                  inactiveThumbColor: Colors.white,
                                  activeColor: AppColors.darkTeal,
                                  inactiveTrackColor: AppColors.darkTeal,
                                  value: notifications,
                                  onChanged: (bool value) {
                                    setState(() {
                                      notifications = value;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        const DrawerItemTitle(title: 'Terma & COnditions'),
                        const DrawerItemTitle(title: 'Privacy Policy'),
                        const DrawerItemTitle(title: 'Contact Us'),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerItemTitle(title: 'Logout'),
                      SizedBox(height: 20),
                      DrawerItemTitle(title: 'Version 1.2.2', fontSize: 14),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItemTitle extends StatelessWidget {
  const DrawerItemTitle({Key? key, required this.title, this.fontSize})
      : super(key: key);
  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          title,
          style: textTheme.bodyMedium!.copyWith(
            fontSize: fontSize ?? 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
