import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenlist1/palette.dart';

class NotesTile extends StatelessWidget {
  String title;
  String notes;
  String date;
  void Function()? deleteFunction;
  void Function()? editFunction;
  NotesTile({
    super.key,
    required this.title,
    required this.notes,
    required this.date,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    //final String date = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(DateTime.now());

    return InkWell(
      onTap: editFunction,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.lightGreyColour, width: 0.7),
          borderRadius: BorderRadius.circular(10),
          color: Palette.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title.capitalize(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Palette.blackColor,
                  fontSize: 16,
                ),
              ),
            ),

            // note
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                notes.capitalize(),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w200,
                  color: Palette.lightBlackColor,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).copyWith(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w200,
                        color: Palette.lightGreyColour,
                        fontSize: 11,
                      ),
                    ),
                    InkWell(
                      onTap: deleteFunction,
                      child: Icon(
                        Icons.delete_outline,
                        color: Palette.lightGreyColour1,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
