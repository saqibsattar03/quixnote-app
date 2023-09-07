import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/add_note.dart';
import 'package:quix_note/src/components/notes/configure_swipe.dart';
import 'package:quix_note/src/components/notes/create_ticket.dart';
import 'package:quix_note/src/components/notes/faq_page.dart';
import 'package:quix_note/src/components/notes/note_detail.dart';
import 'package:quix_note/src/components/notes/search_notes.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:quix_note/src/components/profile/profile_info.dart';
import 'package:quix_note/src/components/sign_up/social_auth.dart';
import 'package:quix_note/src/models/note/note_model.dart';
import 'package:quix_note/src/models/profile/sign_up_model.dart';
import 'package:quix_note/src/service/api/note_api_config.dart';
import 'package:quix_note/src/service/api/profile_api_config.dart';
import 'package:quix_note/src/utils/api_errors.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/widgets/app_circular_button.dart';
import 'package:quix_note/src/widgets/no_data.dart';

import '../sign_up/change_password.dart';
import '../sign_up/privacy_policy.dart';
import '../sign_up/terms_conditions.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool notifications = true;

  var isLoading = true;
  var exception = "";
  var noteModelResponse = <NoteModel>[];
  late SignUpModel signUpModel;
  final api = NoteApiConfig();
  final userApi = ProfileApiConfig();

  Future<void> _init() async {
    await getUserProfile();
    await getAllNotes();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> getUserProfile() async {
    try {
      signUpModel = await userApi.getUserUsingAccessToken();
      setState(() {});
    } catch (e) {
      //ErrorDialog(error: e).show(context);
      exception = ApiError.withDioError(e).title;
      print(
          "<-------------------------------- exception ------------------------------------>${exception}");
      isLoading = false;
      setState(() {});
    }
  }

  Future<void> getAllNotes() async {
    try {
      noteModelResponse = await api.getAllNotes();
    } catch (e) {
      // ErrorDialog(error: e).show(context);
      exception = ApiError.withDioError(e).title;
      print(
          "<-------------------------------- exception ------------------------------------>${exception}");
    }
    isLoading = false;
    setState(() {});
  }

  void splitUserFullName() {
    String? fullName = signUpModel.fullName;
    List<String>? nameParts = fullName?.split(' ');

    if (nameParts!.length >= 2) {
      signUpModel.fullName = nameParts[0];
      // String lastName = nameParts[1];
      // print("First Name: $firstName");
      // print("Last Name: $lastName");
    } else {
      print("Invalid full name format");
    }
  }

  void logout() async {
    await AppData.clearPref();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SocialAuth()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final textTheme = Theme.of(context).textTheme;
    // Adjust the width as needed
    return Scaffold(
      key: _scaffoldKey,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : exception.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        AppImages
                            .noInternet, // Replace with your image file path
                        width: 300,
                        height: 300, // Adjust the height as needed
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 24.0), // Add padding for spacing
                      child: Text(
                        "Oops no internet connection!",
                        style: TextStyle(
                          fontSize: 18, // Adjust the font size as needed
                        ),
                      ),
                    )
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(29, 60, 29, 0),
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
                                svg: SvgPicture.asset(AppImages.search),
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 7),
                              AppCircularButton(
                                onPressed: () {
                                  // AppNavigation.push(const ProfileInfo());
                                  AppNavigation.push(const AddNote());
                                },
                                color: AppColors.lightYellow,
                                svg: SvgPicture.asset(AppImages.plusIcon),
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Hello, ${signUpModel.fullName}",
                        style: textTheme.titleLarge!.copyWith(fontSize: 34),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Welcome to your notes",
                        style: textTheme.titleMedium!.copyWith(),
                      ),
                      const SizedBox(height: 60),
                      Expanded(
                        child: noteModelResponse.isEmpty
                            ? const NoDataWidget(message: "No notes yet")
                            : ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) {
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
                                      AppNavigation.push(NoteDetail(
                                        noteModel: noteModelResponse[index],
                                      ));
                                    },
                                    child: SingleNote(
                                      index: index,
                                      noteModel: noteModelResponse[index],
                                    ),
                                  );
                                },
                                itemCount: noteModelResponse.length,
                              ),
                      )
                    ],
                  ),
                ),
      drawer: isLoading
          ? null
          : Padding(
            padding:  EdgeInsets.only(top: padding.top, bottom: padding.bottom),
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
                                    "${signUpModel.fullName}",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${signUpModel.state},${signUpModel.country}',
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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  AppNavigation.push(const ChangePassword());
                                },
                                child: const DrawerItemTitle(
                                  title: 'Change Password',
                                ),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //       AppNavigation.push(const ConnectAccounts());
                              //     },
                              //     child: const DrawerItemTitle(
                              //         title: 'Connect Account')),
                              InkWell(
                                onTap: () {
                                  AppNavigation.push(const ConfigureSwipe());
                                },
                                child: const DrawerItemTitle(
                                    title: 'Configure swipe'),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const DrawerItemTitle(
                                      title: 'Notifications'),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    height: 30,
                                    width: 40,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch(
                                        inactiveThumbColor: Colors.white,
                                        activeColor: AppColors.darkTeal,
                                        inactiveTrackColor:
                                            AppColors.darkTeal,
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
                                    AppNavigation.push(TermsAndConditions(
                                      callBack: (val) {},
                                      isChecked: true,
                                      isSignupForm: false,
                                    ));
                                  },
                                  child: const DrawerItemTitle(
                                      title: 'Terms & Conditions')),
                              InkWell(
                                  onTap: () {
                                    AppNavigation.push(PrivacyPolicy(
                                      callBack: (val) {},
                                      isChecked: true,
                                      isSignupForm: false,
                                    ));
                                  },
                                  child: const DrawerItemTitle(
                                      title: 'Privacy Policy')),
                              InkWell(
                                  onTap: () {
                                    AppNavigation.push(const CreateTicket());
                                  },
                                  child: const DrawerItemTitle(
                                      title: 'Contact Us')),
                              InkWell(
                                  onTap: () {
                                    AppNavigation.push(const FaqPage());
                                  },
                                  child:
                                      const DrawerItemTitle(title: "FAQ's")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: logout,
                            child: const DrawerItemTitle(title: 'Logout'),
                          ),
                          const SizedBox(height: 20),
                          const DrawerItemTitle(
                              title: 'Version 1.2.2', fontSize: 14),
                          const SizedBox(height: 20),
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
