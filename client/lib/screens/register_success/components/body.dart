import 'package:flutter/material.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/services/utils.dart';

import '../../../auth_manager.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: MediaQuery.of(context).size.height * 0.4, //40%
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Text(
          "Register Success",
          style: headingStyle,
        ),
        Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: DefaultButton(
            text: "Home Page",
            press: (start, stop, state) {
              Utils.popEverythingAndPush(context: context, routeName: AuthManager.routeName);
              //push to homepage
            },
          ),
        ),
        Spacer(),
      ],
    ));
  }
}
