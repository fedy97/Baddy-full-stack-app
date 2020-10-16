import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:polimi_app/models/enum/role.dart';

class Utils {
  static Future<void> showAlertOneButton(
      {@required context,
      @required content,
      @required title,
      @required buttonText}) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
            title: Text(title),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(buttonText))
            ],
          );
        });
  }

  static Widget loadingWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SpinKitSquareCircle(color: Colors.blue));
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
}
