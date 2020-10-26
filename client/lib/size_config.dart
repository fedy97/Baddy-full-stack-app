import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    if (_mediaQueryData == null) {
      _mediaQueryData = MediaQuery.of(context);
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
      orientation = _mediaQueryData.orientation;
    }
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  //double screenHeight = MediaQuery.of(context).size.height;
  //// 812 is the layout height that designer use
  //return (inputHeight / 812.0) * screenHeight;
  return inputHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  //double screenWidth = MediaQuery.of(context).size.width;
  //// 375 is the layout width that designer use
  //return (inputWidth / 375.0) * screenWidth;
  return inputWidth;
}
