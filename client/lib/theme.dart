import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
      appBarTheme: appBarTheme(),
      scaffoldBackgroundColor: Colors.white,
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: kPrimaryColor,
      accentColor: kPrimaryColor);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    // floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: GoogleFonts.montserrat(color: kPrimaryColor),
    bodyText2: GoogleFonts.montserrat(color: kSecondaryColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: kPrimaryColor, //change your color here
    ),
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
    ),
  );
}
