// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/widgets/app_dorpdown.dart';
import 'package:quix_note/src/service/api/note_api_config.dart';
import 'package:quix_note/src/utils/app_colors.dart';
import 'package:quix_note/src/utils/error_dialog.dart';
import 'package:quix_note/src/utils/image_picker.dart';
import 'package:quix_note/src/widgets/app_button.dart';
import 'package:quix_note/src/widgets/app_textfield.dart';

import '../../models/note/note_model.dart';
import 'notes_page.dart';

enum Priority {
  high("High"),
  medium("Medium"),
  low("Low");

  final String value;

  const Priority(this.value);
}

//enum Priority { High, Medium, Low }

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

  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  Priority? _selectedPriority = Priority.high;
  File? _selectedFile;
  var imageUpload;

  void createNote() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (_selectedFile != null) {
        imageUpload = await api.uploadImage(_selectedFile!);
      }
      final createNoteModel = NoteModel(
        title: _titleController.text,
        description: _descriptionController.text,
        priority: _selectedPriority?.name,
        media: imageUpload.toString() ?? "",
        // deadline: DateFormat('dd/MM/yyyy').format(_selectedDate!),
        deadline:_selectedDate,
      );
      await api.creteNote(createNoteModel: createNoteModel);
      if (!mounted) return;
      Navigator.pop(context);
      AppNavigation.push(const NotesPage());
    } catch (e) {
      ErrorDialog(
        error: e,
      ).show(context);
    }
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(9999, 12, 31),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  // pickFile() async {
  //   await FilePickerSheet(
  //     onSelected: (type) async {
  //       try {
  //         FilePickerResult? result = await FilePicker.platform.pickFiles(
  //           allowMultiple: true,
  //           type: type,
  //           // allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'mov'],
  //         );
  //         // if (result != null && result.files.first.size > 50000000) {
  //         //   $showInfoSnackBar('Maximum of 50MBs are allowed');
  //         //   return;
  //         // }
  //         if (result == null) return;
  //         setState(() {});
  //       } catch (_) {}
  //     },
  //   ).show(context);
  // }

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    String formattedDate = _selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
        : 'Set Due Date';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            AppNavigation.pop();
          },
        ),
        title: const Text(
          'Add Note',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'To do is required.';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'Description is required.';
                        }
                        return null;
                      },
                      fillColor: AppColors.lightYellow,
                      maxLines: 3,
                      hint:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: datePicker,
                      child: NoteAction(
                        title: 'Due Date',
                        buttonTitle: formattedDate,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Priority",
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: DropDownFormField<Priority>(
                            errorText: "required",
                            value: _selectedPriority,
                            items: Priority.values.map((e) {
                              return DropdownMenuItem<Priority>(
                                value: e,
                                child: Text(
                                  e.value,
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChangeVal: (value) {
                              _selectedPriority = value;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              filled: true,
                              fillColor: AppColors.primaryYellow,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: AppColors.primaryYellow),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: AppColors.primaryYellow),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        ImagePickerWidget(
                          callback: (f) async {
                            _selectedFile = f;
                            setState(() {});
                          },
                        ).show(context);
                      },
                      child: const NoteAction(
                        title: 'Add Media',
                        buttonTitle: 'Add +',
                      ),
                    ),
                  ],
                ),
                if (_selectedFile != null) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Image.file(_selectedFile!),
                ],
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: AppButton(
                        buttonSize: const Size(double.infinity, 56),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.primaryYellow,
                                  content: Text('Due Date is required!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }
                            createNote();
                          }
                        },
                        // onPressed: () {
                        //   createNote();
                        //   // AppNavigation.push(const MySubscription());
                        // },
                        buttonTitle: 'Save to Phone',
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                )
              ],
            ),
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
