import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'size_config.dart';

const dev = false;
const URL = dev ? "http://10.0.2.2:5001/" : "https://polimi-backend.herokuapp.com/";

const usersRoute = "api/v1/users";
const reviewsRoute = "api/v1/reviews";

const updateDetails = "/updateDetails";

const minCharPassword = 6;

const kPrimaryColor = Colors.purpleAccent;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  //begin: Alignment.topLeft,
  //end: Alignment.bottomRight,
  colors: [Colors.purpleAccent, Color(0xFF473F97)],
);
const kSecondaryGradientColor = LinearGradient(
  colors: [Color(0xFFFFFFFF), Colors.white],
);
const kSecondaryColor = Color(0xFF473F97);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = GoogleFonts.montserrat(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kSecondaryColor,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kNameNullError = "Please Enter your username";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your city";
const kBackgroundColor = Color(0xFFF1EFF1);
const kTextLightColor = Color(0xFF747474);

const kDefaultPadding = 20.0;

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(10, 15),
  blurRadius: 8,
  color: Colors.black12, // Black color with 12% opacity
);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
