import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polimi_app/constants.dart';

class CustomButtonRole extends StatelessWidget {
  final String descr;
  final String image;
  final Function onTap;
  final LinearGradient linearGradient;
  final Color textColor;
  final String key1;

  CustomButtonRole(
      {@required this.descr,
      @required this.image,
      @required this.onTap,
      @required this.linearGradient,
      @required this.textColor,
      this.key1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: Key(this.key1),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(boxShadow: [kDefaultShadow]),
          height: 150,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: linearGradient),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/$image'),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '$descr',
                      style: GoogleFonts.montserrat(
                        color: textColor,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
