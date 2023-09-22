import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../palette.dart';

class NotesTextFormField extends StatelessWidget {
  final TextEditingController controller;
  void Function(String)? onChanged;
  final String validatorText;
  final String hintText;
  final double fontSize;
  final double hintTextFontSize;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color textColor;
  final FontWeight fontWeight;
  final Color fieldColor;
  final maxLines;
  NotesTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.hintTextFontSize,
    required this.textColor,
    required this.fontWeight,
    required this.fieldColor,
    required this.keyboardType,
    required this.obscureText,
    required this.validatorText,
    required this.fontSize,
    required this.maxLines,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: fieldColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
            fontSize: hintTextFontSize,
            fontWeight: fontWeight,
            color: Palette.lightGreyColour),
        errorStyle: GoogleFonts.poppins(
          fontSize: 12,
        ),
      ),
    );
  }
}
