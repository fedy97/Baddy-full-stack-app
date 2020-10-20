import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  static Future<Map> getMe(String jwt) async {
    try {
      var dio = Dio();
      Response response = await dio.get(URL + usersRoute + "/me",
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      //print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  static Future<String> uploadImage(
      {@required PickedFile image,
      @required String username,
      @required int timestamp,
      @required String jwt}) async {
    String path = _createPath(username, timestamp.toString());
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageRef.putFile(File(image.path), StorageMetadata());
    final snapshot = await uploadTask.onComplete;
    if (snapshot.error != null) throw snapshot.error;
    String url = await snapshot.ref.getDownloadURL();

    try {
      var dio = Dio();
      Response response = await dio.patch(URL + usersRoute + "/updateDetails",
          data: {"photo": url},
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
    } on DioError catch (e) {
      print(e.response);
      return "default.jpg";
    }

    return url;
  }

  static String _createPath(String username, String timestamp) {
    //mail/timestampRecord/imagesList
    return "$username/$timestamp/" + "photo.jpg";
  }
}
