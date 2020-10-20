import 'dart:convert';

import 'package:dio/dio.dart';

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
}
