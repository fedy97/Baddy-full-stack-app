import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polimi_app/services/access_manager.dart';

import '../constants.dart';

class Apis {
  static Future<Map> getAvailableUsers(String jwt) async {
    try {
      var dio = Dio();
      Response response = await dio.get(URL + usersRoute + "/available",
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      //print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  static Future<Map> updateProfile(String jwt, Map body) async {
    try {
      var dio = Dio();
      Response response = await dio.patch(URL + usersRoute + "/updateDetails",
          data: jsonEncode(body),
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  static void updateRegistrationToken(String jwt, String registrationToken) async {
    var body = {'registrationToken': registrationToken};
    try {
      var dio = Dio();
      await dio.put(URL + usersRoute + "/registrationToken",
          data: jsonEncode(body),
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      print(jsonEncode(body));
      print("Called " + URL + usersRoute + "/registrationToken with $jwt");
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  static Future<Map> getMe(String jwt) async {
    try {
      var dio = Dio();
      Response response = await dio.get(URL + usersRoute + "/me",
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      //print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      if (e.response.data["error"]["statusCode"] == 401 || e.response.data["error"]["statusCode"] == 500)
        await AccessManager.signOut();
      return null;
    }
  }

  static Future<String> uploadImage(
      {@required PickedFile image,
      @required String username,
      @required int timestamp,
      @required String jwt}) async {
    try {
      File imageFile = File(image.path);
      String path = _createPath(username, timestamp.toString());
      final storageRef = FirebaseStorage.instance.ref().child(path);
      await storageRef.putFile(imageFile);
      final url = await storageRef.getDownloadURL();
      var dio = Dio();
      Response response = await dio.patch(URL + usersRoute + "/updateDetails",
          data: {"photo": url},
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      return url;
    } on DioError catch (e) {
      print(e.response);
      return "default.jpg";
    } catch (e) {
      print(e);
      return "default.jpg";
    }
  }

  static String _createPath(String username, String timestamp) {
    //mail/timestampRecord/imagesList
    return "$username/$timestamp/" + "photo.jpg";
  }

  static Future<Map> sendReview(String jwt, Map body) async {
    try {
      var dio = Dio();
      Response response = await dio.post(URL + reviewsRoute + "/",
          data: jsonEncode(body),
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return e.response.data;
    }
  }

  static Future<Map> getUserReviews(String username, String jwt) async {
    try {
      var dio = Dio();
      Response response = await dio.get(URL + reviewsRoute + "/user/$username",
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return e.response.data;
    }
  }
}
