import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/components/sign_up/change_password.dart';
import 'package:quix_note/src/service/api/profile_api_config.dart';
import 'package:quix_note/src/utils/api_errors.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/app_images.dart';
import 'package:quix_note/src/controllers/profile_controller.dart';

import '../../base/nav.dart';
import '../../models/profile/sign_up_model.dart';
import '../../service/upload_service.dart';
import '../../utils/error_dialog.dart';
import '../../utils/image_picker.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  //controllers

  final fullNameController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  final api = ProfileApiConfig();
  final _formKey = GlobalKey<FormState>();

  var isLoading = true;
  var image;
  File? _selectedFile;

  ApiError? _error;
  bool get _hasError => _error != null;

  Future<void> getProfile() async {
    try {
      final user = await api.getUserUsingAccessToken();
      fullNameController.text = user.fullName ?? '';
      countryController.text = user.country ?? '';
      stateController.text = user.state ?? '';
      cityController.text = user.city ?? '';
      image = user.profileImage ?? '';
      _error = null;
    } catch (e) {
      _error = ApiError.withDioError(e);
    }
    isLoading = false;
    setState(() {});
  }

  Future<void> _init() async {
    await getProfile();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void editProfile() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      var imageUrl;
      if (_selectedFile != null) {
        imageUrl = await UploadService.uploadImage(_selectedFile!);
      }
      final userModel = SignUpModel(
        fullName: fullNameController.text,
        country: countryController.text,
        state: stateController.text,
        city: cityController.text,
        profileImage: imageUrl ?? image,
      );
      await api.editProfile(model: userModel, id: AppData.loggedUserId);
      await ProfileController.instance.refresh();
      if (!mounted) return;
      Navigator.pop(context);
      AppNavigation.pop();
    } catch (e) {
      ErrorDialog(
        error: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Info",
          style: textTheme.titleLarge!.copyWith(fontSize: 22),
        ),
        leading: IconButton(
          // Add a back button
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text(_error?.description ?? ''))
              : SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 135,
                          width: 135,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14.0),
                                child: _selectedFile != null
                                    ? Image.file(
                                        _selectedFile!,
                                        height: 127,
                                        width: 127,
                                        fit: BoxFit.fill,
                                      )
                                    : image.isNotEmpty
                                        ? Image.network(
                                            image,
                                            height: 127,
                                            width: 127,
                                            fit: BoxFit.fill,
                                            loadingBuilder: (_, child,
                                                    loadingProgress) =>
                                                loadingProgress == null
                                                    ? child
                                                    : Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      ),
                                          )
                                        : SvgPicture.asset(
                                            AppImages.avatarFrame,
                                            height: 127,
                                            width: 127,
                                          ),
                              ),

                              // if (_selectedFile != null)
                              //   ClipRRect(
                              //       borderRadius: BorderRadius.circular(14.0),
                              //       child: Image.asset(
                              //         _selectedFile!.path,
                              //         height: 127,
                              //         width: 127,
                              //         fit: BoxFit.fill,
                              //       ))
                              // else
                              //   image != ''
                              //       ? ClipRRect(
                              //           borderRadius: BorderRadius.circular(14.0),
                              //           child: Image.network(
                              //             image,
                              //             height: 127,
                              //             width: 127,
                              //             fit: BoxFit.fill,
                              //             loadingBuilder:
                              //                 (_, child, loadingProgress) {
                              //               if (loadingProgress == null) {
                              //                 return child;
                              //               }
                              //               return Container(
                              //                 alignment: Alignment.center,
                              //                 child:
                              //                     const CircularProgressIndicator(),
                              //               );
                              //             },
                              //           ))
                              //       : SvgPicture.asset(
                              //           AppImages.avatarFrame,
                              //           height: 127,
                              //           width: 127,
                              //         ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkTeal,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.darkTeal.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: const Offset(-3, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: InkWell(
                                        onTap: () async {
                                          ImagePickerWidget(
                                            callback: (f) async {
                                              _selectedFile = f;
                                              setState(() {});
                                            },
                                          ).show(context);
                                        },
                                        child: SvgPicture.asset(
                                            AppImages.editIcon)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 29),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 45,
                                ),
                                const FieldTitle(title: 'Full Name'),
                                const SizedBox(height: 10),
                                AppTextField(
                                  textEditingController: fullNameController,
                                  hint: 'John Doe',
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return 'Name is required.';
                                    }
                                    return null;
                                  },
                                  fillColor: AppColors.lightYellow,
                                ),
                                const FieldTitle(title: 'Country'),
                                const SizedBox(height: 10),
                                AppTextField(
                                  textEditingController: countryController,
                                  hint: 'United States America',
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().isEmpty) {
                                      return 'Country is required.';
                                    }
                                    return null;
                                  },
                                  fillColor: AppColors.lightYellow,
                                ),
                                const FieldTitle(title: 'City'),
                                const SizedBox(height: 10),
                                AppTextField(
                                  textEditingController: stateController,
                                  hint: 'New York (optional)',
                                  fillColor: AppColors.lightYellow,
                                ),
                                const FieldTitle(title: 'State'),
                                const SizedBox(height: 10),
                                AppTextField(
                                  textEditingController: cityController,
                                  hint: 'Great street 01 (optional)',
                                  fillColor: AppColors.lightYellow,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: AppButton(
                              buttonSize: const Size(double.infinity, 50),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  editProfile();
                                  setState(() {});
                                }
                              },
                              // onPressed: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const VerifyEmailScreen()),
                              //   );
                              // },
                              buttonTitle: 'Next',
                            ),
                          ),
                          const SizedBox(height: 40)
                        ]),
                      ],
                    ),
                  ),
                ),
    );
  }
}
