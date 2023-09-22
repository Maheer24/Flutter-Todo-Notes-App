import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenlist1/palette.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final void Function(BuildContext)? deleteFunction;
  Future<void> Function() editFunction;

  ToDoTile({
    super.key,
    required this.title,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Slidable(
        enabled: true,
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              label: "Delete",
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Color(0xfff5f5f5),
              foregroundColor: Palette.lightGreyColour,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: editFunction,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15,).copyWith(top: 17),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Palette.lightGreyColour, width: 0.7),
              color: Palette.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title.capitalize(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Palette.greyColour,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension MyExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
