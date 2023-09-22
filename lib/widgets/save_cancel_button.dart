import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../palette.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 20,),
      decoration: BoxDecoration(
       color: Palette.lightPurpleColor,
      
      ),
      
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            text,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w200,
                color: Palette.greyColour),
          ),
        ),
      
    );
  }
}
