import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenlist1/palette.dart';
import 'package:zenlist1/utils/routes/routes_name.dart';
import 'package:zenlist1/utils/model/todo_task_model.dart';
import 'package:zenlist1/utils/utils.dart';
import 'package:zenlist1/widgets/to_do_tile.dart';
import 'package:zenlist1/widgets/custom_text_form_field.dart';
import 'package:zenlist1/widgets/dialog_box.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

class ToDoPage extends StatefulWidget {
  ToDoPage({
    super.key,
  });

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  late DialogBox _dialogBox;
  final databaseReference = FirebaseDatabase.instance.ref("Task");
  final _auth = FirebaseAuth.instance;
  List<ToDoTask> todoTasks = [];

  final searchController = TextEditingController();

  // on save edit function
  Future<void> onSaveEdit(String updatedTaskText, String taskId) async {
    try {
      databaseReference.child(taskId).update({
        'task': updatedTaskText,
      });
      Navigator.pop(context);
    } catch (e) {
      Utils().toastMessage(e.toString(), context);
    }
  }

  // edit tasks function
  Future<void> editTasks(String title, String taskId) async {
    _dialogBox = DialogBox(
      initialTaskText: title,
      onSave: () {
        // pass the original task text and task id on save
        onSaveEdit(_dialogBox.taskController.text.toString(), taskId);
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    );

    showDialog(
      context: context,
      builder: (context) {
        return _dialogBox;
      },
    );
  }

  // save new task
  void saveNewTask() {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    databaseReference.child(id).set({
      'id': id,
      "task": _dialogBox.taskController.text.toString()
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), context);
    });
    Navigator.pop(context);
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        _dialogBox = DialogBox(
          initialTaskText: '',
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();
          },
        );

        return _dialogBox;
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.whiteColor,
        appBar: AppBar(
          backgroundColor: Palette.whiteColor,
          elevation: 0,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          title: Text(
            "To-do list",
            style: GoogleFonts.raleway(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Palette.lightGreyColour),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                _auth.signOut().then((value) {
                  Navigator.pushNamed(context, RouteName.loginScreen);
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString(), context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.logout_outlined,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              CustomTextFormField(
                controller: searchController,
                hintText: "Search for tasks",
                icon: Icons.search_rounded,
                keyboardType: TextInputType.text,
                obscureText: false,
                validatorText: "",
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  defaultChild: const Center(
                    child: CircularProgressIndicator(
                      color: Palette.lightGreyColour,
                    ),
                  ),
                  query: databaseReference,
                  itemBuilder: (context, snapshot, animation, index) {
                    final taskTitle = snapshot.child('task').value.toString();
                    final id = snapshot.child('id').value.toString();

                    if (searchController.text.isEmpty) {
                      return ToDoTile(
                        title: taskTitle,
                        deleteFunction: (p0) {
                          databaseReference
                              .child(snapshot.child('id').value.toString())
                              .remove();
                        },
                        editFunction: () async {
                          editTasks(taskTitle, id);
                        },
                      );
                    } else if ((taskTitle.toLowerCase().contains(
                        searchController.text.toLowerCase().toString()))) {
                      return ToDoTile(
                        title: taskTitle,
                        deleteFunction: (p0) {
                          databaseReference
                              .child(snapshot.child('id').value.toString())
                              .remove();
                        },
                        editFunction: () async {
                          editTasks(taskTitle, id);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          elevation: 1,
          shape: CircleBorder(eccentricity: 1),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
