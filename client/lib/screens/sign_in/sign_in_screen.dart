import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('built sign in');
    //final detectKeyboard =
    //KeyboardVisibilityNotification().addNewListener(onHide: () {
    //  FocusScope.of(context).unfocus();
    //});
    return GestureDetector(
        onTap: () {
          //Utils.hideKeyboard(context: context);
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: kPrimaryColor, //change your color here
            ),
            title: Text("Sign In"),
          ),
          body: Body(),
        ));
  }
}
