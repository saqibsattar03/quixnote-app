// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class FilePickerSheet extends StatefulWidget {
//   const FilePickerSheet({
//     Key? key,
//     required this.onSelected,
//   }) : super(key: key);
//
//   final void Function(FileType) onSelected;
//
//   Future<void> show(BuildContext context) async {
//     await showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       builder: (_) => this,
//       barrierColor: Colors.transparent,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20),
//           topLeft: Radius.circular(20),
//         ),
//       ),
//     );
//   }
//
//   @override
//   State<FilePickerSheet> createState() => _FilePickerSheetState();
// }
//
// class _FilePickerSheetState extends State<FilePickerSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _getTile(
//           title: 'Camera',
//           icon: CupertinoIcons.camera,
//           onTap: () {
//             widget.onSelected(FileType.image);
//           },
//         ),
//         _getTile(
//           title: 'Gallery',
//           icon: CupertinoIcons.folder,
//           onTap: () {
//             widget.onSelected(FileType.video);
//           },
//         ),
//         SizedBox(height: MediaQuery.of(context).padding.bottom),
//       ],
//     );
//   }
//
//   Future<XFile?> selectFile()async {
//
//   }
//
//   Widget _getTile({
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       onTap: onTap,
//       leading: Icon(icon, color: Colors.grey),
//       title: Text(title),
//     );
//   }
// }
