import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/custom_surfix_icon.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/services/access_manager.dart';
import 'package:polimi_app/services/utils.dart';

import '../../../auth_manager.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final storage = new FlutterSecureStorage();
  static final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: (start,stop,state) async {
              if (_formKey.currentState.validate()) {
                start();
                try {
                  Response response =
                      await AccessManager.signIn(username, password, remember);
                  stop();
                  if (response.data["status"] == "success")
                    Utils.popEverythingAndPush(
                        context: context, routeName: AuthManager.routeName);
                  else {
                    await Utils.showAlertOneButton(
                        buttonText: "Ok",
                        content: response.data["message"],
                        title: "Error!",
                        context: context);
                  }
                } catch (e) {
                  stop();
                  await Utils.showAlertOneButton(
                      buttonText: "Ok",
                      content: "check your internet connection",
                      title: "Error!",
                      context: context);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: TextStyle(
        color: kSecondaryColor,
      ),
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= minCharPassword) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < minCharPassword) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: customInputDecoration(title: "Password", iconName: "Lock"),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      style: TextStyle(
        color: kSecondaryColor,
      ),
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        username = value;
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: customInputDecoration(title: "Username", iconName: "User"),
    );
  }
}
