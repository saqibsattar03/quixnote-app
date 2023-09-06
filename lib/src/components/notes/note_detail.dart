import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quix_note/src/base/data.dart';
import 'package:quix_note/src/models/comment/comment_model.dart';
import 'package:quix_note/src/models/comment/comment_response_model.dart';
import 'package:quix_note/src/models/note/note_model.dart';
import 'package:quix_note/src/service/api/comment_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';
import '../../base/nav.dart';
import '../../utils/error_dialog.dart';
import '../../widgets/no_data.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({Key? key, required this.noteModel}) : super(key: key);
  final NoteModel noteModel;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  //controllers
  final _commentController = TextEditingController();
  final api = CommentApiConfig();

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
      final commentModel = CommentModel(
          userId: AppData.loggedUserId,
          noteId: widget.noteModel.id!,
          comment: _commentController.text);
      await api.postComment(commentModel: commentModel);
      await api.getAllCommentByNoteId(noteId: widget.noteModel.id!);
      if (!mounted) return;

      Navigator.pop(context);
      // AppNavigation.pop();
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.noteModel.priority.toString(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.primaryYellow,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.noteModel.title.toString(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.calendar_month_sharp,
                            color: AppColors.primaryYellow,
                          ),
                        )),
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
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'My Todo',
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.noteModel.description.toString(),
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.noteModel.media != "null")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                color: Colors.black,
                                width: 2.0,
                              ),
                              color: Colors.black,
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
                                    child: const CircularProgressIndicator(),
                                  );
                                },
                              ), // Your image widget goes here
                            ),
                          ),
                        ),
                      ] else ...[
                        const Center(child: Text('No Media Available!')),
                      ],
                    ],
                  ),
                const SizedBox(height: 20),
                Text(
                  'VA Comments',
                  style: textTheme.bodyMedium!.copyWith(
                    color: AppColors.darkTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  maxLines: 1,
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
                    icon: const Icon(Icons.attachment_outlined),
                    onPressed: postComment,
                  ),
                  fillColor: const Color(0xffefefef),
                ),
                const SizedBox(height: 20),
                CommentItem(noteId: widget.noteModel.id!),
                // const SizedBox(height: 10),
                // const CommentItem(),
              ],
            ),
          )),
    );
  }
}

class CommentItem extends StatefulWidget {
  const CommentItem({Key? key, required this.noteId}) : super(key: key);

  final String noteId;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  final api = CommentApiConfig();
  var isLoading = true;
  var commentResponseModel = <CommentResponseModel>[];

  @override
  void initState() {
    super.initState();
    getAllComments();
  }

  void getAllComments() async {
    try {
      commentResponseModel =
          await api.getAllCommentByNoteId(noteId: widget.noteId);
    } catch (e) {
      ErrorDialog(error: e).show(context);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: commentResponseModel.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        foregroundColor: AppColors.primaryYellow,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            commentResponseModel[index].fullName,
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            commentResponseModel[index].comment,
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGrey,
                            ),
                          )
                        ],
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
              );
            },
          ),
        ],
      ),
    );
  }
}


// @override
// Widget build(BuildContext context) {
//   final textTheme = Theme.of(context).textTheme;
//   return commentResponseModel.isEmpty
//       ? const NoDataWidget(message: "No notes yet")
//       : ListView.separated(
//           shrinkWrap: true,
//           itemCount: commentResponseModel.length,
//           separatorBuilder: (BuildContext context, int index) {
//             return const Divider(
//               height: 10,
//               thickness: 1,
//               indent: 10,
//               endIndent: 10,
//               color: AppColors.dividerGrey,
//             );
//           },
//           itemBuilder: (context, index) {
//             return Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 25,
//                   foregroundColor: AppColors.primaryYellow,
//                   child: Icon(Icons.person),
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       commentResponseModel[index].fullName,
//                       style: textTheme.bodyMedium!.copyWith(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.darkGrey,
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       commentResponseModel[index].comment,
//                       style: textTheme.bodyMedium!.copyWith(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.darkGrey),
//                     )
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
// }