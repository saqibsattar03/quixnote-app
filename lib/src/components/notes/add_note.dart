import 'package:flutter/material.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/my_subscription.dart';

import 'package:quix_note/src/service/api/note_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

import '../../models/note/note_model.dart';
import 'notes_page.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  //controllers

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final api = NoteApiConfig();


  void createNote() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try{
      final createNoteModel = NoteModel(title: _titleController.text, description: _descriptionController.text, priority: "High", projectName: "Test Project", deadline: "12-01-2024");
      await api.creteNote(createNoteModel: createNoteModel);
      Navigator.pop(context);
      AppNavigation.push(const NotesPage());
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {AppNavigation.pop();},
        ),
        title: const Text(
          'Add Note',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                   AppTextField(
                    textEditingController: _titleController,
                    fillColor: AppColors.lightYellow,
                    hint: 'My To do',
                  ),
                  Text(
                    'Description',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                   AppTextField(
                    textEditingController: _descriptionController,
                    fillColor: AppColors.lightYellow,
                    maxLines: 3,
                    hint:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
                  ),
                  const SizedBox(height: 20),
                  const NoteAction(title: 'Due Date', buttonTitle: 'Set Date'),
                  const SizedBox(height: 10),
                  const NoteAction(title: 'Due Date', buttonTitle: 'High'),
                  const SizedBox(height: 10),
                  const NoteAction(title: 'Add Media', buttonTitle: 'Add +'),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppButton(
                        buttonSize:  const Size(double.infinity, 56),
                        onPressed: () {
                          createNote();
                      // AppNavigation.push(const MySubscription());

                    }, buttonTitle: 'Save to Phone'),
                  ),
                  const SizedBox(height: 30)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoteAction extends StatelessWidget {
  const NoteAction({
    Key? key,
    required this.title,
    required this.buttonTitle,
  }) : super(key: key);
  final String title;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: const BoxDecoration(
            color: AppColors.primaryYellow,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Text(
            buttonTitle,
            style: textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
