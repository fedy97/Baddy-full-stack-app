import 'package:flutter/material.dart';
import 'package:polimi_app/components/custom_button_role.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/sign_in/sign_up/sign_up_screen.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class ChooseRolePage extends StatelessWidget {
  static String routeName = "/chooseRole";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kSecondaryColor, //change your color here
          ),
        ),
        body: Container(
            color: kPrimaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(36),
                      bottomLeft: Radius.circular(36),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Who are you?',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(40),
                            color: kSecondaryColor),
                      ),
                      CustomButtonRole(
                        descr: 'Caregiver',
                        image: 'doctor.png',
                        onTap: () {
                          //put read if inside a tap function, otherwise watch
                          context.read<Model>().isRegisteringAsStandard = false;
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        linearGradient: kPrimaryGradientColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 10),
                  child: CustomButtonRole(
                    key1: "customer_role_button",
                    descr: 'Customer',
                    image: 'user.png',
                    onTap: () {
                      context.read<Model>().isRegisteringAsStandard = true;
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    textColor: kSecondaryColor,
                    linearGradient: kSecondaryGradientColor,
                  ),
                )
              ],
            )));
  }
}
