import 'package:dio/dio.dart' as dio;

import '../constants.dart';

class Apis {
  static Future<bool> getAvailableUsers(String jwt) async {
    try {
      var http = dio.Dio();
      dio.Response response = await http.get(URL + usersRoute + "/available",
          options: dio.Options(headers: {'Authorization': 'Token $jwt'}));
      print(response);
      return true;
    } catch (e) {
      return false;
    }
  }
}
