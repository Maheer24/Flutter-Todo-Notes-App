import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zenlist1/palette.dart';
import 'package:zenlist1/utils/utils.dart';
import 'package:zenlist1/widgets/notes_text_form_field.dart';

class CreateNotePage extends StatefulWidget {
  CreateNotePage({
    super.key,
  });

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final databaseReference = FirebaseDatabase.instance.ref('Notes');
  final noteController = TextEditingController();
  final titleController = TextEditingController();
  bool isSaveEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Add listeners to the text controllers to enable/disable the save button
    titleController.addListener(updateSaveButtonState);
    noteController.addListener(updateSaveButtonState);
  }

  void updateSaveButtonState() {
    // Enable the save button if both the title and note text are not empty
    setState(() {
      isSaveEnabled =
          titleController.text.isNotEmpty && noteController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    titleController.removeListener(updateSaveButtonState);
    noteController.removeListener(updateSaveButtonState);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.whiteColor,
        appBar: AppBar(
          backgroundColor: Palette.whiteColor,
          toolbarHeight: 70,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.check_outlined,
                  size: 30,
                  color: isSaveEnabled
                      ? Palette.lightBlackColor
                      : Palette.lightGreyColour1,
                ),
                onTap: () {
                  if (isSaveEnabled) {
                    final id = DateTime.now().millisecondsSinceEpoch.toString();
                    databaseReference
                        .child(id)
                        .set({
                          'id': id,
                          'title': titleController.text.toString(),
                          'note': noteController.text.toString(),
                          'date': DateFormat("MMM d, h:mm a")
                              .format(DateTime.now()),
                        })
                        .then((value) {})
                        .onError((error, stackTrace) {
                          Utils().toastMessage(error.toString(), context);
                        });
                    Navigator.pop(context);
                  }
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ).copyWith(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NotesTextFormField(
                  controller: titleController,
                  hintText: "Title",
                  maxLines: 1,
                  textColor: Palette.blackColor,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validatorText: "Add title",
                  fieldColor: Palette.whiteColor,
                  fontSize: 28,
                  hintTextFontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
                NotesTextFormField(
                  controller: noteController,
                  hintText: "Note",
                  maxLines: null,
                  textColor: Palette.lightBlackColor,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validatorText: "Add Note",
                  fieldColor: Palette.whiteColor,
                  fontSize: 16,
                  hintTextFontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
