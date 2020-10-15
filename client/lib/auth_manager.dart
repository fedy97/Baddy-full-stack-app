import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import 'models/user/standardUser.dart';
import 'models/user/user.dart';
import 'screens/home_page/products_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'services/access_manager.dart';

class AuthManager extends StatelessWidget {
  static String routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data["jwt"] != null) {
            var str = snapshot.data["jwt"];
            var jwt = str.split(".");
            var remember = snapshot.data["remember"];
            if (jwt.length != 3) {
              return SignInScreen();
            } else {
              var payload = json.decode(
                  ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              User firstUser = StandardUser.fromMap(payload, str);
              //print(firstUser.toString());
              if (remember == "true" &&
                  DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                      .isAfter(DateTime.now())) {
                return ChangeNotifierProvider<User>.value(
                    value: firstUser, child: ProductsScreen());
              } else {
                AccessManager.signOut().then((value) => SignInScreen());
              }
              return ChangeNotifierProvider<User>.value(
                  value: firstUser, child: ProductsScreen());
            }
          } else {
            return SplashScreen();
          }
        });
  }

  Future<Map> get jwtOrEmpty async {
    Map jwtRemember = Map();
    var storage = FlutterSecureStorage();
    var jwt = await storage.read(key: "jwt");
    var remember = await storage.read(key: "remember");
    if (jwt == null) return jwtRemember;
    jwtRemember["jwt"] = jwt;
    jwtRemember["remember"] = remember;
    return jwtRemember;
  }
}
