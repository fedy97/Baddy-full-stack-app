import 'package:flutter/material.dart';
import 'package:polimi_app/services/utils.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
        onTap: () {
          Utils.hideKeyboard(context: context);
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
