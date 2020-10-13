import 'package:flutter/material.dart';
import 'package:polimi_app/components/default_button.dart';

import '../../../auth_manager.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Register Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Home Page",
            press: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AuthManager.routeName, (Route<dynamic> route) => false);
              //push to homepage
            },
          ),
        ),
        Spacer(),
      ],
    ));
  }
}
