import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polimi_app/screens/onboarding_page/onboarding_page.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:polimi_app/services/utils.dart';
import 'package:polimi_app/size_config.dart';
import 'package:provider/provider.dart';

import 'models/model.dart';
import 'models/user/standardUser.dart';
import 'models/user/user.dart';
import 'screens/home_page/home_page.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'services/access_manager.dart';

class AuthManager extends StatelessWidget {
  static String routeName = "/auth";
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Utils.loadingWidget();
          if (snapshot.data["jwt"] != null) {
            var str = snapshot.data["jwt"];
            var user = snapshot.data["user"];
            var jwt = str.split(".");
            var remember = snapshot.data["remember"];
            if (jwt.length != 3) {
              //jwt format not valid
              return SplashScreen();
            } else {
              //jwt formatted correctly, let's decode it
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              User loggedUser = StandardUser.fromMap(user, str);
              model.user = loggedUser;
              if (remember == "true" &&
                  DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                      .isAfter(DateTime.now())) {
                //goes here if jwt is valid and it was a remember me
                return HomePage();
              } else {
                //goes here if jwt is no longer valid or user did not press remember me
                AccessManager.signOut().then((value) => SignInScreen());
              }
              //never goes here
              return SizedBox.shrink();
            }
          } else {
            //jwt missing
            return SplashScreen();
          }
        });
  }

  Future<Map> get jwtOrEmpty async {
    Map jwtRemember = Map();
    Map userRes;
    var storage = FlutterSecureStorage();
    var jwt = await storage.read(key: "jwt");
    var remember = await storage.read(key: "remember");
    if (jwt == null) return jwtRemember;
    if (jwt != "invalid.value") userRes = (await Apis.getMe(jwt))["user"];
    jwtRemember["user"] = userRes;
    jwtRemember["jwt"] = jwt;
    jwtRemember["remember"] = remember;
    return jwtRemember;
  }
}
