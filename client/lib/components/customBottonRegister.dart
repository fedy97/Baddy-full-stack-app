import 'package:flutter/material.dart';

class CustomBottonRegister extends StatelessWidget {
  final String descr;
  final String image;
  final Function onTap;
  final LinearGradient linearGradient;
  final Color textColor;

  CustomBottonRegister(
      {@required this.descr,
      @required this.image,
      @required this.onTap,
      @required this.linearGradient,
      @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
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
                    Image.asset('assets/images/${image}'),
                    SizedBox(
                      width: 45,
                    ),
                    Text(
                      '$descr',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
