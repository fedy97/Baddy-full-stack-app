import 'package:flutter/material.dart';
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

  static Role stringToRole({String string}) {
    return Role.values.firstWhere((element) => element.toString() == string);
  }
}
