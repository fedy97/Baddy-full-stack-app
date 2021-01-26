import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polimi_app/constants.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Text("BADDY",
            style: GoogleFonts.montserrat(color: kPrimaryColor, fontSize: 50)),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(color: kPrimaryColor, ),
        ),
        SizedBox(height: 10,),
        Image.asset(
          image,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(350),
        ),
      ],
    ));
  }
}
