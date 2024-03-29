import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';

class AccessManager {
  ///It signs in a user calling signInWithEmailAndPassword function
  static Future<Response> signIn(
      String username, String password, bool remember) async {
    try {
      //User u = await signInWithEmailAndPassword(email, password);
      //return true;
      var storage = FlutterSecureStorage();
      Response response = await Dio().post(URL + usersRoute + "/login",
          data: {"username": username, "password": password});
      if (response.data["status"] == "success") {
        await storage.write(key: 'jwt', value: response.data["token"]);
        await storage.write(key: 'remember', value: remember.toString());
      }
      return response;
    } on DioError catch (e) {
      //falls here if status code != 2xx or 304
      return e.response;
    }
  }

  static Future<Response> createStandardUser(
      String email, String password, String username) async {
    var signUpUrl = URL + usersRoute + "/signup";
    try {
      Response response = await Dio().post(signUpUrl,
          data: {"email": email, "username": username, "password": password});

      var storage = FlutterSecureStorage();
      await storage.write(key: 'jwt', value: response.data["token"]);
      await storage.write(key: 'remember', value: "true");

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  ///It creates a other role user
  static Future<Response> createOtherUser(
      {String email,
      String password,
      String username,
      String name,
      String surname,
      String city,
      String phone,
      double lat,
      double long}) async {
    var signUpUrl = URL + usersRoute + "/signup";
    try {
      Response response = await Dio().post(signUpUrl, data: {
        "role": "other",
        "email": email,
        "username": username,
        "password": password,
        "city": city,
        "phone": phone,
        "firstName": name,
        "lastName": surname,
        "latitude": lat,
        "longitude": long
      });

      var storage = FlutterSecureStorage();
      await storage.write(key: 'jwt', value: response.data["token"]);
      await storage.write(key: 'remember', value: "true");

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  static Future<void> signOut() async {
    //return await _firebaseAuth.signOut();
    var storage = FlutterSecureStorage();
    await storage.delete(key: "remember");
    await storage.write(key: 'logOnce', value: "loggedOut");
    return await storage.write(key: 'jwt', value: "invalid.value");
  }
}
