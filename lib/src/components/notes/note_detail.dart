import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/models/comment/comment_model.dart';
import 'package:quix_note/src/models/note/note_model.dart';
import 'package:quix_note/src/service/api/comment_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/dynamic_link.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';
import 'package:reusables/reusables.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/note_controller.dart';
import '../../service/upload_service.dart';
import '../../utils/api_errors.dart';
import '../../utils/app_images.dart';
import '../../utils/error_dialog.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({Key? key, required this.noteModel}) : super(key: key);
  final NoteModel noteModel;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  //controllers
  final _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final api = CommentApiConfig();
  File? _selectedFile;
  final notesController = NotesController();

  void postComment() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      var imageUrl = '';
      if (_selectedFile != null) {
        imageUrl = await UploadService.uploadImage(_selectedFile!);
      }
      final commentModel = CommentModel(
        userId: AppData.loggedUserId,
        noteId: widget.noteModel.id!,
        comment: _commentController.text,
        media: imageUrl,
      );
      await api.postComment(commentModel: commentModel);

      await notesController.getAllComment(widget.noteModel!.id!);
      // await api.getAllCommentByNoteId(noteId: widget.noteModel.id!);
      _commentController.clear();

      if (!mounted) return;
      Navigator.pop(context);
      // AppNavigation.pop();
      setState(() {
        setState(() {});
      });
    } catch (e) {
      ErrorDialog(
        error: e,
      ).show(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.clear();
  }

  Widget wrapWithSliver(Widget child) {
    return SliverToBoxAdapter(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Note detail',
          style: textTheme.bodyMedium!.copyWith(
            fontSize: 18,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  DynamicLinkProvide()
                      .createLink(widget.noteModel.id.toString())
                      .then((value) {
                    print("${value}");
                    Share.share(value);
                  });
                },
                value: 1,
                child: Text(
                  "Share",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: Text(
                  "Delete",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
            offset: const Offset(10, 20),
            color: Colors.white,
            elevation: 2,
            surfaceTintColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            wrapWithSliver(const SizedBox(height: 20)),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              sliver: wrapWithSliver(
                Text(
                  widget.noteModel.priority.toString(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryYellow,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            wrapWithSliver(Text(
              widget.noteModel.title.toString(),
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.darkTeal,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: wrapWithSliver(Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.calendar_month_sharp,
                        color: AppColors.primaryYellow,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deadline',
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: AppColors.darkGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat('E, d MMMM')
                            .format(widget.noteModel.deadline!)
                            .toString(),
                        style: textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            wrapWithSliver(Text(
              'My Todo',
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.darkTeal,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              sliver: wrapWithSliver(Text(
                widget.noteModel.description.toString(),
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              )),
            ),
            if (widget.noteModel.media != "null")
              wrapWithSliver(
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Media',
                    style: textTheme.bodyMedium!.copyWith(
                      color: AppColors.darkTeal,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.noteModel.media?.isNotEmpty ?? false) ...[
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.noteModel.media ?? '',
                            fit: BoxFit.fill,
                            loadingBuilder: (_, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: const CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    const Center(child: Text('No Media Available!')),
                  ],
                ]),
              ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              sliver: wrapWithSliver(Text(
                'VA Comments',
                style: textTheme.bodyMedium!.copyWith(
                  color: AppColors.darkTeal,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              )),
            ),
            wrapWithSliver(Form(
              key: _formKey,
              child: AppTextField(
                minLines: 1,
                maxLines: 3,
                textEditingController: _commentController,
                // textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'Comment Text is required.';
                  }
                  return null;
                },
                hint: 'Comment',
                suffix: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      postComment();
                      setState(() {});
                    }
                  },
                ),
                fillColor: const Color(0xffefefef),
              ),
            )),
            wrapWithSliver(const SizedBox(height: 20)),
            CommentItem(notesController, noteId: widget.noteModel.id!)
          ],
        ),
      ),
    );
  }
}

class CommentItem extends ControlledWidget<NotesController> {
  final NotesController notesController;

  const CommentItem(this.notesController, {Key? key, required this.noteId})
      : super(key: key, controller: notesController);

  final String noteId;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> with ControlledStateMixin {
  // final api = CommentApiConfig();
  // var isLoading = true;
  // var commentResponseModel = <CommentResponseModel>[];

  ApiError? _error;
  bool get _hasError => _error != null;

  @override
  void initState() {
    super.initState();
    widget.controller.getAllComment(widget.noteId);
    //getAllComments();
  }

  // void getAllComments() async {
  //   try {
  //     commentResponseModel =
  //         await api.getAllCommentByNoteId(noteId: widget.noteId);
  //   } catch (e) {
  //     ErrorDialog(error: e).show(context);
  //   }
  //   isLoading = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (widget.controller.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (widget.controller.hasError) {
      return SliverToBoxAdapter(
        child:Center(child: Text(widget.controller.error.description ?? '')),
      );
    } else {
      if (widget.controller.comment!.isEmpty) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No comments yet!"),
                Icon(Icons.message), // Add the message icon here
              ],
            ),
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, i) {
              final comment = widget.controller.comment![i];
              return widget.controller.comment!.isNotEmpty
                  ? Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (comment.role == "ADMIN")
                                ? Stack(
                                    children: [
                                      ClipOval(
                                        child: SvgPicture.asset(
                                          AppImages.avatarFrame,
                                          height: 52,
                                          width: 52,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.verified,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : (comment.profileImage != null &&
                                        comment.profileImage != "")
                                    ? CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 26,
                                        backgroundImage:
                                            NetworkImage(comment.profileImage!),
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 26,
                                        child: Icon(Icons.person),
                                      ),

// : const CircleAvatar(
//     backgroundColor: Colors.black,
//     radius: 26,
//     child: Icon(Icons.person),
//   ),
// (comment.profileImage != null)
//     ? Stack(
//   children: [
//     CircleAvatar(
//       backgroundColor: Colors.black,
//       radius: 26,
//       backgroundImage: NetworkImage(
//         comment.profileImage!,
//       ),
//     ),
//     if (comment.role =="ADMIN") // Check if the comment is from an admin
//       Positioned(
//         bottom: 0,
//         right: 0,
//         child: Container(
//           padding: EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             Icons.verified,
//             color: Colors.white,
//             size: 16,
//           ),
//         ),
//       ),
//   ],
// )
//     : const CircleAvatar(
//   backgroundColor: Colors.black,
//   radius: 26,
//   child: Icon(Icons.person),
// ),

// comment.profileImage != null
//     ? CircleAvatar(
//         backgroundColor: Colors.black,
//         radius: 26,
//         backgroundImage: NetworkImage(
//           comment.profileImage!,
//         ),
//       )
//     : const CircleAvatar(
//         backgroundColor: Colors.black,
//         radius: 26,
//         child: Icon(Icons.person),
//       ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.fullName,
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),

                                  ///*** add image in comment ***//
// if (comment.media!.isNotEmpty)
//   Image.network(
//     comment.media!,
//     height: 100,
//     width: 150,
//     fit: BoxFit.fill,
//     loadingBuilder: (_, child, loadingProgress) {
//       if (loadingProgress == null) {
//         return child;
//       }
//       return Center(
//         child: Container(
//             alignment: Alignment.center,
//             color: Colors.white,
//             height: 30,
//             width: 30,
//             child: const CircularProgressIndicator()),
//       );
//     },
//   ),
                                  const SizedBox(width: 5),
                                  Text(
                                    // maxLines: 4,
                                    comment.comment,
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGrey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 10,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                          color: AppColors.dividerGrey,
                        ),
                      ],
                    )
                  : Container();
            },
            childCount: widget.controller.comment!.length,
          ),
        );
      }
    }
  }
}
