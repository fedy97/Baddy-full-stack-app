import 'package:flutter/material.dart';

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
  ///this return some errors from firebase,
  ///for example if the email is badly formatted during the sign up process
  static String printError(String errorToParse) {
    String errorTrimmed = errorToParse.split("]")[1];
    if (errorTrimmed != null)
      return errorTrimmed;
    return errorToParse;
  }
}
