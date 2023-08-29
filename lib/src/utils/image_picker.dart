import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../base/nav.dart';
import 'app_colors.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    Key? key,
    required this.callback,
    this.isImagePicker = true,
  }) : super(key: key);

  final bool isImagePicker;
  final void Function(File?) callback;

  Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => this,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getTile(
          title: 'Gallery',
          icon: CupertinoIcons.folder,
          onTap: () async => await _pickMedia(imageSource: ImageSource.gallery),
        ),
        _getTile(
          title: 'Camera',
          icon: CupertinoIcons.camera,
          onTap: () async => await _pickMedia(imageSource: ImageSource.camera),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  Widget _getTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Future<void> _pickMedia({required ImageSource imageSource}) async {
    XFile? pickedFile;
    if (widget.isImagePicker) {
      pickedFile = await ImagePicker().pickImage(source: imageSource);
    } else {
      pickedFile = await ImagePicker().pickVideo(source: imageSource);
    }
    if (pickedFile == null) return;
    widget.callback(File(pickedFile.path));
    if (mounted) if (widget.isImagePicker) AppNavigation.pop(context);
  }
}
