import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../palette.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  bool loading;
  double width;
  Color borderColor;
  Color? buttonColor;
  Color textColor;
  bool showImage;
  RoundButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
    required this.width,
    required this.buttonColor,
    required this.borderColor,
    required this.textColor,
    required this.showImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: buttonColor,
          border: Border.all(width: width, color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: loading
                  ? const CircularProgressIndicator(
                      color: Palette.whiteColor,
                      strokeWidth: 4,
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: textColor,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
            ),
            if (showImage)
              Container(
                margin: EdgeInsets.only(left: 8),
                height: 30,
                width: 30,
                child: Image.asset("images/google.png"),
              ),
          ],
        ),
      ),
    );
  }
}
