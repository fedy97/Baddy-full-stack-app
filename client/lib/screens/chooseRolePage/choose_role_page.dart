import 'package:flutter/material.dart';
import 'package:polimi_app/components/customBottonRegister.dart';
import 'package:polimi_app/constants.dart';
import 'package:polimi_app/models/model.dart';
import 'package:polimi_app/screens/sign_in/sign_up/sign_up_screen.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';

class ChooseRolePage extends StatelessWidget {
  static String routeName = "/chooseRole";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            color: kPrimaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.55,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Cosa sei?',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(40),
                            color: kPrimaryColor),
                      ),
                      CustomBottonRegister(
                        descr: 'Badante',
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
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 26),
                  child: CustomBottonRegister(
                    descr: 'Cliente',
                    image: 'user.png',
                    onTap: () {
                      context.read<Model>().isRegisteringAsStandard = true;
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    textColor: kPrimaryColor,
                    linearGradient: kSecondaryGradientColor,
                  ),
                )
              ],
            )));
  }
}
