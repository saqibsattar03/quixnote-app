import 'package:flutter/material.dart';
import 'package:quix_note/src/models/note/note_model.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

class NoteDetail extends StatelessWidget {
  const NoteDetail({Key? key, required this.noteModel}) : super(key: key);
  final NoteModel noteModel;
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
                  "About",
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
              noteModel.priority.toString(),
              // 'Low Priority',
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.primaryYellow,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              noteModel.title.toString(),
              // 'Redesign Splash Screen',
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.darkTeal,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.snapchat,
                            color: Colors.yellow,
                          ),
                        )),
                    const SizedBox(width: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project',
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            color: AppColors.darkGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Snapchat',
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
                          noteModel.deadline.toString(),
                          // 'Mon,7 March',
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
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
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              noteModel.description.toString(),
              // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus interdum mattis fringilla. Sed dolor risus, lacinia vitae euismod in, varius sit amet augue.',
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'VA Comments',
              style: textTheme.bodyMedium!.copyWith(
                color: AppColors.darkTeal,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              maxLines: 1,
              hint: 'Comment',
              suffix: IconButton(
                icon: const Icon(Icons.attachment_outlined),
                onPressed: () {},
              ),
              fillColor: const Color(0xffefefef),
            ),
            const SizedBox(height: 20),
            const CommentItem(),
            const SizedBox(height: 10),
            const CommentItem(),
          ],
        )),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          child: Icon(Icons.person),
          foregroundColor: AppColors.primaryYellow,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Richard R',
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrey,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Lorem ipsum dolor sit amet, consectetur',
              style: textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrey),
            )
          ],
        )
      ],
    );
  }
}
