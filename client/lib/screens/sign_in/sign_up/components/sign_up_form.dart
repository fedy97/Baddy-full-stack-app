import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:polimi_app/components/custom_input_decoration.dart';
import 'package:polimi_app/components/default_button.dart';
import 'package:polimi_app/components/form_error.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:polimi_app/screens/register_success/register_success_screen.dart';
import 'package:polimi_app/services/access_manager.dart';
import 'package:polimi_app/services/utils.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  String username;
  String email;
  String password;
  String confirm_password;
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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: (start,stop,state) async {
              if (_formKey.currentState.validate()) {
                if (context.read<Model>().isRegisteringAsStandard) {
                  start();
                  try {
                    _formKey.currentState.save();
                    Response response = await AccessManager.createStandardUser(
                        email, password, username);
                    stop();
                    if (response.data["status"] == "success")
                      Utils.popEverythingAndPush(
                          context: context,
                          routeName: RegisterSuccessScreen.routeName);
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
                } else {
                  //save values in model, in order to use them in another context
                  context.read<Model>().tempValues = {
                    "username": username,
                    "password": password,
                    "email": email
                  };
                  //register as badante
                  Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      style: TextStyle(
        color: kSecondaryColor,
      ),
      obscureText: true,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        //confirm_password = value;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == value) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (password != value) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: customInputDecoration(title: "Confirm Password", iconName: "Lock"),
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
        //password = value;
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= minCharPassword) {
          removeError(error: kShortPassError);
        }
        password = value;
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
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        email = value;
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: customInputDecoration(title: "Mail", iconName: "Mail"),
    );
  }

  TextFormField buildNameFormField() {
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
        return null;
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
