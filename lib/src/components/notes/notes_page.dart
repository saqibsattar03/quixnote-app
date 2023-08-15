import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/configure_swipe.dart';
import 'package:quix_note/src/components/notes/connect_account.dart';
import 'package:quix_note/src/components/notes/create_ticket.dart';
import 'package:quix_note/src/components/notes/note_detail.dart';
import 'package:quix_note/src/components/notes/search_notes.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:quix_note/src/components/profile/profile_info.dart';
import 'package:quix_note/src/components/sign_up/change_password.dart';
import 'package:quix_note/src/components/sign_up/privacy_policy.dart';
import 'package:quix_note/src/components/sign_up/terms_conditions.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_circular_button.dart';

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
        padding: const EdgeInsets.fromLTRB(29, 60,29, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCircularButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  color: AppColors.extraLightGrey,
                  svg: SvgPicture.asset(AppImages.category),
                  height: 70,
                  width: 70,
                ),
                Row(
                  children: [
                    AppCircularButton(
                        onPressed: () {
                          AppNavigation.push(const SearchNotes());
                        },
                        color: AppColors.lightYellow,
                        svg: SvgPicture.asset(AppImages.search)),
                    AppCircularButton(
                        onPressed: () {
                          AppNavigation.push(const ProfileInfo());
                        },
                        color: AppColors.lightYellow,
                        svg: SvgPicture.asset(AppImages.plusIcon)),
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
                return InkWell(
                    onTap: () {
                      AppNavigation.push(const NoteDetail());
                    },
                    child: SingleNote(index: index));
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
                          InkWell(
                            onTap: () {
                              AppNavigation.push(const ProfileInfo());
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 26,
                              child: Icon(Icons.person),
                            ),
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
                        InkWell(
                            onTap: () {
                              AppNavigation.push(const ChangePassword());
                            },
                            child: const DrawerItemTitle(
                                title: 'Change Password')),
                        InkWell(
                            onTap: () {
                              AppNavigation.push(const ConnectAccounts());
                            },
                            child: const DrawerItemTitle(
                                title: 'Connect Account')),
                        InkWell(
                          onTap: () {
                            AppNavigation.push(const ConfigureSwipe());
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
                        InkWell(
                            onTap: () {
                              AppNavigation.push(const TermsAndConditions());
                            },
                            child: const DrawerItemTitle(
                                title: 'Terms & Conditions')),
                        InkWell(
                            onTap: () {
                              AppNavigation.push(const PrivacyPolicy());
                            },
                            child:
                                const DrawerItemTitle(title: 'Privacy Policy')),
                        InkWell(
                            onTap: () {
                              AppNavigation.push(const CreateTicket());
                            },
                            child: const DrawerItemTitle(title: 'Contact Us')),
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
        const SizedBox(height: 25)
      ],
    );
  }
}
