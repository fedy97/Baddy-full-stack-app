import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polimi_app/components/no_account_text.dart';
import 'package:polimi_app/components/socal_card.dart';
import 'package:polimi_app/constants.dart';

import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    "Welcome Back",
                    style: headingStyle,
                  ),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e,trace) {
      print(trace);
      print('error $e');
      return Container();
    }
  }
}
