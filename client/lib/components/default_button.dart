import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.textColor,
    this.bgColor
  }) : super(key: key);
  final String text;
  final Function press;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      elevation: 5,
      color: bgColor ?? kPrimaryColor,
        loader: Container(
          padding: EdgeInsets.all(10),
          child: SpinKitRotatingCircle(
            color: textColor ?? Colors.white,
            // size: loaderWidth ,
          ),
        ),
        borderRadius: 50,
        width: MediaQuery.of(context).size.width,
        height: getProportionateScreenHeight(50),
        child: Text(text,
          style: GoogleFonts.montserrat(
            fontSize: getProportionateScreenWidth(18),
            color: textColor ?? Colors.white,
          ),
        ),
        onTap: press
        );
  }
}
