import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'custom_surfix_icon.dart';

InputDecoration customInputDecoration({String iconName, @required String title}) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: kSecondaryColor,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: kSecondaryColor,
        width: 1.0,
      ),
    ),
    labelText: title,
    hintText: "Inserisci",
    labelStyle: GoogleFonts.montserrat(color: kPrimaryColor),
    hintStyle: GoogleFonts.montserrat(color: kPrimaryColor),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/${iconName ?? "Trash"}.svg"),
  );
}
