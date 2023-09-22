import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenlist1/palette.dart';
import 'package:zenlist1/widgets/custom_text_form_field.dart';
import 'package:zenlist1/widgets/save_cancel_button.dart';

class DialogBox extends StatelessWidget {
  VoidCallback onSave;
  VoidCallback onCancel;
  String initialTaskText;

  DialogBox({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.initialTaskText,
  }) {
    // Set the initial task text in the controller
    taskController.text = initialTaskText;
  }

  final databaseReference = FirebaseDatabase.instance.ref();
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Palette.whiteColor,
      content: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        height: 200,
        child: Column(
          children: [
            // get user input
            CustomTextFormField(
              controller: taskController,
              hintText: "Add new task",
              icon: Icons.edit,
              keyboardType: TextInputType.text,
              obscureText: false,
              validatorText: "Enter task",
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Save",
                  onTap: () {
                    if (taskController.text.isNotEmpty) {
                      onSave();
                    }
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                //cancel button
                MyButton(
                  text: "Cancel",
                  onTap: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
