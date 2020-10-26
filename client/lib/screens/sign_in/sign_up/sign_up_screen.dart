import 'package:flutter/material.dart';
import 'package:polimi_app/services/utils.dart';

import '../../../constants.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  static var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //final detectKeyboard =
    //KeyboardVisibilityNotification().addNewListener(onHide: () {
    //  FocusScope.of(context).unfocus();
    //});
    return GestureDetector(
        onTap: () {
          Utils.hideKeyboard(context: context);
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: kSecondaryColor, //change your color here
            ),
            title: Text("Sign Up"),
          ),
          body: Body(),
        ));
  }
}
