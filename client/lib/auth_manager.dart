import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:polimi_app/services/apis.dart';
import 'package:polimi_app/services/utils.dart';
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
            var logOnce = snapshot.data["logOnce"];
            if (jwt.length != 3) {
              //jwt format not valid, like `invalid.value`
              return SignInScreen();
            } else {
              //jwt formatted correctly, let's decode it
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              User loggedUser = StandardUser.fromMap(user, str);
              model.user = loggedUser;
              //check if jwt has expired
              if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                      .isAfter(DateTime.now()) &&
                  logOnce != "nextTimeRelog") {
                var storage = FlutterSecureStorage();
                if (remember == "false")
                  storage.write(key: 'logOnce', value: "nextTimeRelog");
                else
                  storage.write(key: 'logOnce', value: "keepMeLogged");
                //update firebase token
                putRegistrationToken(str);

                return HomePage();
              } else {
                var storage = FlutterSecureStorage();
                //goes here if jwt is expired or user did not press remember me
                AccessManager.signOut();
                storage.write(key: 'logOnce', value: "nextLogIamIn");
              }
              //goes here as soon as the above log out is triggered
              return SignInScreen();
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
    var logOnce = await storage.read(key: "logOnce");
    if (logOnce == null) logOnce = "firstTimeLogged";
    if (jwt == null) return jwtRemember;
    if (jwt != "invalid.value") userRes = (await Apis.getMe(jwt))["user"];
    // goes here if jwt expired
    if (userRes == null) {
      jwtRemember["jwt"] = 'invalid.value';
      return jwtRemember;
    }
    jwtRemember["user"] = userRes;
    jwtRemember["jwt"] = jwt;
    jwtRemember["remember"] = remember;
    jwtRemember["logOnce"] = logOnce;
    return jwtRemember;
  }

  void putRegistrationToken(String jwt) async {
    String clientToken = await FirebaseMessaging.instance.getToken();
    //print("FCM Token" + clientToken);
    await Apis.updateRegistrationToken(jwt, clientToken);
  }
}
