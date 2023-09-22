import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenlist1/ui/pages/edit_note_page.dart';
import 'package:zenlist1/utils/utils.dart';
import 'package:zenlist1/widgets/custom_text_form_field.dart';
import 'package:zenlist1/widgets/notes_tile.dart';

import '../../palette.dart';
import '../../utils/routes/routes_name.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref('Notes');
  final searchController = TextEditingController();
  List<dynamic> notesList = [];

  // delete note
  Future<void> deleteNoteFunction(String noteId) async {
    databaseReference.child(noteId).remove().onError((error, stackTrace) =>
        Utils().toastMessage("Delete error: $error", context));
  }

  // edit note
  Future<void> editNoteFunction(
      String noteTitle, String noteText, String noteId) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNotePage(
            initialNoteTitle: noteTitle,
            initialNoteText: noteText,
            noteId: noteId,
          ),
        ));
  }

  // filter notes
  void filterNotes(String searchText) {
    setState(() {
      notesList = notesList.where((note) {
        final title = note['title'].toString().toLowerCase();
        return title.contains(searchText.toLowerCase());
      }).toList();
    });
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
            "Notes",
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
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
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
                hintText: "Search for notes",
                icon: Icons.search_rounded,
                keyboardType: TextInputType.text,
                obscureText: false,
                validatorText: "",
                onChanged: (String value) {
                  filterNotes(value);
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              Expanded(
                child: StreamBuilder(
                  stream: databaseReference.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    try {
                      debugPrint("Snapshot:${snapshot.data!.snapshot.value}");
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Palette.lightGreyColour,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        debugPrint("Firebase Error: ${snapshot.error}");
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: Text(
                            "Add a note",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Palette.lightGreyColour),
                          ),
                        );
                      } else {
                        final snapshotValue = snapshot.data!.snapshot.value;

                        Map<dynamic, dynamic> map = snapshotValue as dynamic;
                        debugPrint("Map: $map");
                        List<dynamic> notesList = [];
                        notesList.clear();
                        notesList = map.values.toList();
                        debugPrint("Notes List: $notesList");

                        return MasonryGridView.count(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            final title = notesList[index]['title'].toString();
                            final note =
                                notesList[index]['note']?.toString() ?? "";
                            final date =
                                notesList[index]['date']?.toString() ?? "";
                            final noteId =
                                notesList[index]['id']?.toString() ?? "";
                            debugPrint(note);
                            if (searchController.text.isEmpty) {
                              return NotesTile(
                                title: title,
                                notes: note,
                                date: date,
                                deleteFunction: () {
                                  deleteNoteFunction(noteId);
                                },
                                editFunction: () {
                                  editNoteFunction(title, note, noteId);
                                },
                              );
                            } else if (title.toLowerCase().contains(
                                searchController.text
                                    .toLowerCase()
                                    .toString())) {
                              return NotesTile(
                                title: title,
                                notes: note,
                                date: date,
                                deleteFunction: () {
                                  deleteNoteFunction(noteId);
                                },
                                editFunction: () {
                                  editNoteFunction(title, note, noteId);
                                },
                              );
                            } else {
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            }
                          },
                        );
                      }
                    } catch (e) {
                      debugPrint("Error in stream builder: $e");
                      return Center(
                        child: Text(
                          "Add a note",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Palette.lightGreyColour),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.createNotePage);
          },
          elevation: 1,
          shape: const CircleBorder(eccentricity: 1),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
