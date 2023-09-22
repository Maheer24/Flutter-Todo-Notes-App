import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../palette.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String validatorText;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    required this.obscureText,
    required this.validatorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w200,
        color: Palette.greyColour,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Palette.emailPasswordFieldColour,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w200,
            color: Palette.lightGreyColour),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.emailPasswordFieldColour,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Palette.lightGreyColour,
            width: 1,
          ),
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 12,
        ),
        prefixIcon: Icon(icon, color: Palette.lightGreyColour),
      ),
    );
  }
}
