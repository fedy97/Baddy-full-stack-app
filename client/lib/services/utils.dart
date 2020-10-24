import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/enum/role.dart';
import 'package:polimi_app/size_config.dart';

class Utils {
  static Future<void> showAlertOneButton(
      {@required context,
      @required content,
      @required title,
      @required buttonText}) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: title,
        desc: content,
        btnOkText: buttonText,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
    //return showDialog(
    //    context: context,
    //    barrierDismissible: false,
    //    builder: (context) {
    //      return AlertDialog(
    //        content: Text(content),
    //        title: Text(title),
    //        actions: [
    //          FlatButton(
    //              onPressed: () {
    //                Navigator.pop(context);
    //              },
    //              child: Text(buttonText))
    //        ],
    //      );
    //    });
  }

  static Widget loadingWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SpinKitDoubleBounce(color: kPrimaryColor));
  }

  ///used when a page is waiting for something from the net.
  /// other animations are here {https://pub.dev/documentation/flutter_spinkit/latest/}
  static void showProgress(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loadingWidget()));
  }

  static Role stringToRole({String string}) {
    return Role.values.firstWhere((element) => element.toString() == string);
  }

  static void popEverythingAndPush({BuildContext context, String routeName}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  //depracated, use alert_service.dart instead
  static void showSnack({GlobalKey<ScaffoldState> key, String text}) {
    key.currentState.showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      backgroundColor: kSecondaryColor,
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      content: Text(text),
    ));
  }

  static void hideKeyboard({@required BuildContext context}) {
    FocusScope.of(context).unfocus();
  }
}
